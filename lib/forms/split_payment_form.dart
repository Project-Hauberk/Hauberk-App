part of 'package:hauberk/main.dart';

class SplitPaymentForm extends StatefulWidget {
  const SplitPaymentForm({super.key});

  @override
  State<StatefulWidget> createState() => SplitPaymentFormState();
}

class SplitPaymentFormState extends State<SplitPaymentForm> {
  late final Future<List<QueryDocumentSnapshot<Account>>> loadAccountsFuture =
      () async {
    accounts
      ..addAll((await accountsColl.get()).docs)
      ..addAll((await externalAccountsColl.get()).docs);
    return accounts;
  }();
  final List<QueryDocumentSnapshot<Account>> accounts = [];

  final TextEditingController fromAccAmtController = TextEditingController();
  final TextEditingController transactionsController = TextEditingController();
  final List<({Account account, TextEditingController amountController})>
      splits = [];

  Account? fromAcc;
  Transaction? chosenTransaction;

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      backgroundColor: Colors.transparent,
      builder: (ctx) => Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: Dimensions.width(),
          height: Dimensions.height() * 0.7,
          decoration: BoxDecoration(
            color: HauberkColors.darkGreen5,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: Border.all(
              color: HauberkColors.brightGreen5,
              strokeAlign: BorderSide.strokeAlignOutside,
            ),
            boxShadow: [
              BoxShadow(
                color: HauberkColors.brightGreen5.withOpacity(0.2),
                blurRadius: 20,
                spreadRadius: 10,
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: Dimensions.width(),
              height: Dimensions.height() * 0.7,
              child: SingleChildScrollView(
                child: FutureBuilder(
                  future: loadAccountsFuture,
                  builder: (ctx, snapshot) => snapshot.standardHandler(
                    () => Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Chosen Transaction
                        FutureBuilder(
                          future: (() async => await txnsColl
                              .orderBy('timestamp')
                              .limit(10)
                              .get())(),
                          builder: (ctx, snapshot) => snapshot.standardHandler(
                            () => DropdownMenu(
                              controller: transactionsController,
                              onSelected: (value) async {
                                if (value == null) return;
                                chosenTransaction =
                                    (await txnsColl.doc(value).get()).data();
                                fromAcc = accounts
                                    .firstWhere((snapshot) =>
                                        snapshot.id ==
                                        chosenTransaction!.fromAccountId)
                                    .data();
                                fromAccAmtController.text = chosenTransaction!
                                    .amount
                                    .toStringAsFixed(2);
                                setState(() {});
                              },
                              label: const Text('Choose a payment to split'),
                              inputDecorationTheme: InputDecorationTheme(
                                hintStyle: body1.apply(
                                  TextStyle(
                                    color: HauberkColors.brightGreen5
                                        .withOpacity(0.3),
                                  ),
                                ),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: HauberkColors.brightGreen5
                                        .withOpacity(0.3),
                                  ),
                                ),
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: HauberkColors.brightGreen5
                                        .withOpacity(0.5),
                                  ),
                                ),
                              ),
                              dropdownMenuEntries: [
                                for (QueryDocumentSnapshot<Transaction> txnDoc
                                    in snapshot.data?.docs ?? const [])
                                  DropdownMenuEntry(
                                    value: txnDoc.id,
                                    label: txnDoc.data().description ??
                                        '${DateTime.fromMillisecondsSinceEpoch(txnDoc.data().timestamp as int).toDDMMYYYY()} \$${txnDoc.data().amount.toStringAsFixed(2)} ${txnDoc.data().txnType.name}',
                                  ),
                              ],
                            ),
                          ),
                        ),
                        // Splits
                        if (chosenTransaction != null)
                          SizedBox(
                            width: Dimensions.width(),
                            height: 90 * (splits.length + 1),
                            child: Column(
                              children: [...buildSplitsEntries(context)],
                            ),
                          ),
                        const SizedBox(height: 40),
                        chosenTransaction != null
                            ? SizedBox(
                                width: 160,
                                height: 80,
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      splits.add(
                                        (
                                          account: accounts.first.data(),
                                          amountController:
                                              TextEditingController()
                                                ..text = '0',
                                        ),
                                      );
                                    });
                                  },
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.add,
                                      ),
                                      const Spacer(),
                                      Text('Add new'),
                                    ],
                                  ),
                                ),
                              )
                            : TextButton(
                                onPressed: () async {
                                  final Transaction? txn =
                                      await showModalBottomSheet(
                                    context: ctx,
                                    builder: (_) => const AddTransactionForm(),
                                  );
                                  if (txn != null) {
                                    setState(() {
                                      chosenTransaction = txn;
                                    });
                                  }
                                },
                                child: Text('Add a transaction'),
                              ),
                        const SizedBox(height: 60),
                        SizedBox(
                          width: 300,
                          height: 60,
                          child: TextButton(
                            onPressed: () async {
                              if (validateForm()) {
                                for (final split in splits) {
                                  if (split.account.ownerId ==
                                      FirebaseAuth.instance.currentUser!.uid) {
                                    final accDoc = (await accountsColl
                                            .where('name',
                                                isEqualTo: split.account.name)
                                            .limit(1)
                                            .get())
                                        .docs[0];
                                    accountsColl.doc(accDoc.id).update({
                                      'balance': accDoc.data().balance -
                                          double.parse(
                                              split.amountController.text)
                                    });
                                  } else {
                                    final accDoc = (await externalAccountsColl
                                            .where('name',
                                                isEqualTo: split.account.name)
                                            .limit(1)
                                            .get())
                                        .docs[0];
                                    externalAccountsColl.doc(accDoc.id).update({
                                      'balance': accDoc.data().balance -
                                          double.parse(
                                              split.amountController.text)
                                    });
                                  }
                                }
                                accountsColl.doc();
                                if (context.mounted) {
                                  Navigator.of(context).pop();
                                }
                              }
                            },
                            child: Container(
                              width: 300,
                              height: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color:
                                    HauberkColors.brightGreen5.withOpacity(0.2),
                              ),
                              child: Center(
                                child: Text(
                                  'Finish',
                                  style: body1.apply(),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> buildSplitsEntries(BuildContext context) {
    final List<Widget> widgets = [];
    double selfAmt = chosenTransaction!.amount;
    for (int i = 0; i < splits.length; i++) {
      selfAmt -= double.tryParse(splits[i].amountController.text) ?? 0;
      widgets.addAll([
        const SizedBox(height: 20),
        buildSplitEntry(
          i,
          context,
          amountController: splits[i].amountController,
          chosenAccount: splits[i].account,
        ),
      ]);
    }
    fromAccAmtController.text = selfAmt.toStringAsFixed(2);
    widgets.insert(
      0,
      buildSplitEntry(
        0,
        context,
        chosenAccount: fromAcc!,
        amountController: fromAccAmtController,
        readOnly: true,
      ),
    );

    return widgets;
  }

  Widget buildSplitEntry(
    int index,
    BuildContext context, {
    required Account chosenAccount,
    required TextEditingController amountController,
    bool readOnly = false,
  }) {
    return Container(
      width: Dimensions.width(),
      height: 70,
      decoration: BoxDecoration(
        border: Border.all(color: HauberkColors.brightGreen4),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 7,
              bottom: 7,
            ),
            child: DropdownMenu<Account>(
              enabled: !readOnly,
              label: const Text('Account'),
              initialSelection: chosenAccount,
              onSelected: (value) {
                if (value != null) {
                  splits[index] = (
                    account: value,
                    amountController: amountController,
                  );
                }
              },
              inputDecorationTheme: InputDecorationTheme(
                hintStyle: body1.apply(
                  TextStyle(
                    color: HauberkColors.brightGreen5.withOpacity(0.3),
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: HauberkColors.brightGreen5.withOpacity(0.3),
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: HauberkColors.brightGreen5.withOpacity(0.5),
                  ),
                ),
              ),
              dropdownMenuEntries: [
                for (QueryDocumentSnapshot<Account> accDoc in accounts)
                  DropdownMenuEntry(
                    value: accDoc.data(),
                    label: accDoc.data().name,
                  ),
              ],
            ),
          ),
          const VerticalDivider(
            thickness: 1,
            color: HauberkColors.brightGreen4,
          ),
          Padding(
            padding: const EdgeInsets.only(
              left: 10,
              right: 10,
              top: 7,
              bottom: 7,
            ),
            child: // Amount
                SizedBox(
              width: Dimensions.width() - 255,
              height: 40,
              child: TextField(
                controller: amountController,
                style: body1.apply(const TextStyle(fontSize: 14)),
                textInputAction: TextInputAction.next,
                readOnly: readOnly,
                onEditingComplete: () => setState(() {}),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                decoration: InputDecoration(
                  prefixIcon: Icon(
                    Icons.attach_money,
                    size: 24,
                    color: HauberkColors.brightGreen5.withOpacity(0.5),
                  ),
                  hintText: 'Enter the amount for this account',
                  hintStyle: body1.apply(
                    TextStyle(
                      color: HauberkColors.brightGreen5.withOpacity(0.3),
                    ),
                  ),
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: HauberkColors.brightGreen5.withOpacity(0.3),
                    ),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                      color: HauberkColors.brightGreen5.withOpacity(0.5),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Spacer(),
          if (index != 0)
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 7,
                bottom: 7,
              ),
              child: TextButton(
                onPressed: () {
                  splits.removeAt(index);
                  setState(() {});
                },
                child: Icon(Icons.remove),
              ),
            ),
        ],
      ),
    );
  }

  bool validateForm() {
    final List<Account> usedAccs = [];
    for (final split in splits) {
      if (usedAccs.contains(split.account)) {
        return false;
      } else {
        usedAccs.add(split.account);
      }
      if (double.parse(fromAccAmtController.text).isNegative) {
        return false;
      } else {
        return true;
      }
    }
    return true;
  }

  @override
  void dispose() {
    transactionsController.dispose();
    for (final split in splits) {
      split.amountController.dispose();
    }
    super.dispose();
  }
}
