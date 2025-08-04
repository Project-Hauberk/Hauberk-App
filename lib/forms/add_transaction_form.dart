part of 'package:hauberk/main.dart';

class AddTransactionForm extends StatefulWidget {
  const AddTransactionForm({super.key});

  @override
  State<StatefulWidget> createState() => AddTransactionFormState();
}

class AddTransactionFormState extends State<AddTransactionForm> {
  final Future<QuerySnapshot<Account>> loadAccounts =
      (() async => accountsColl.get())();

  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController amountController = TextEditingController();
  final TextEditingController tagsController = TextEditingController();
  final TextEditingController timestampController =
      TextEditingController(text: DateTime.now().toIso8601String());
  final TextEditingController txnTypeController = TextEditingController();
  final TextEditingController fromAccController = TextEditingController();
  final TextEditingController toAccController = TextEditingController();
  (String, String) accOwners = ('', '');

  String fromAccId = '';
  String toAccId = '';

  void updateTxnType() {
    final String txnType;
    if (accOwners.$1 == userId) {
      if (accOwners.$2 == userId) {
        txnType = 'Transfer';
      } else if (accOwners.$2 == '') {
        txnType = 'Outflow';
      } else {
        txnType = 'Outflow or Repayment'; // or Repayment
      }
    } else {
      if (accOwners.$1 == '') {
        txnType = 'Inflow';
      } else {
        if (accOwners.$2 == userId) {
          txnType = 'Inflow or Payment';
        } else {
          throw Exception('All clauses matched');
        }
      }
    }
    txnTypeController.text = txnType;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Align(
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
                child: Column(
                  children: [
                    // Description
                    TextField(
                      style: body1.apply(),
                      controller: descriptionController,
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Describe the transaction',
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
                    const SizedBox(height: 20),
                    // Amount
                    TextField(
                      controller: amountController,
                      style: body1.apply(const TextStyle(fontSize: 14)),
                      textInputAction: TextInputAction.next,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.attach_money,
                          size: 24,
                          color: HauberkColors.brightGreen5.withOpacity(0.5),
                        ),
                        hintText: 'Amount',
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
                    const SizedBox(height: 20),
                    // FromAcc, ToAcc
                    FutureBuilder(
                      future: loadAccounts,
                      builder: (ctx, snapshot) => snapshot.standardHandler(
                        () => Row(
                          children: [
                            DropdownMenu(
                              controller: fromAccController,
                              label: const Text('From'),
                              onSelected: (val) => setState(() {
                                accOwners =
                                    (val?.data().ownerId ?? '', accOwners.$2);
                                fromAccId = val?.id ?? '';
                                updateTxnType();
                              }),
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
                                for (QueryDocumentSnapshot<Account> accDoc
                                    in snapshot.data?.docs ?? const [])
                                  DropdownMenuEntry(
                                    value: accDoc,
                                    label: accDoc.data().name,
                                  ),
                              ],
                            ),
                            const SizedBox(width: 16),
                            Icon(
                              Icons.arrow_right,
                              size: 36,
                              color:
                                  HauberkColors.brightGreen5.withOpacity(0.6),
                            ),
                            const SizedBox(width: 16),
                            DropdownMenu(
                              label: const Text('To'),
                              controller: toAccController,
                              onSelected: (val) => setState(() {
                                accOwners =
                                    (accOwners.$1, val?.data().ownerId ?? '');
                                toAccId = val?.id ?? '';

                                updateTxnType();
                              }),
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
                                for (QueryDocumentSnapshot<Account> accDoc
                                    in snapshot.data?.docs ?? const [])
                                  DropdownMenuEntry(
                                    value: accDoc,
                                    label: accDoc.data().name,
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    // Tags
                    FutureBuilder(
                      future: (() async => tagsColl.get())(),
                      builder: (ctx, snapshot) => snapshot.standardHandler(
                        () => DropdownMenu(
                          controller: tagsController,
                          label: const Text('Tags'),
                          inputDecorationTheme: InputDecorationTheme(
                            hintStyle: body1.apply(
                              TextStyle(
                                color:
                                    HauberkColors.brightGreen5.withOpacity(0.3),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    HauberkColors.brightGreen5.withOpacity(0.3),
                              ),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color:
                                    HauberkColors.brightGreen5.withOpacity(0.5),
                              ),
                            ),
                          ),
                          dropdownMenuEntries: [
                            for (final tagDoc
                                in snapshot.data?.docs ?? const [])
                              DropdownMenuEntry(
                                value: tagDoc.id,
                                label: tagDoc.data().label,
                              ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    // Timestamp
                    TextField(
                      controller: timestampController,
                      style: body1.apply(),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Timestamp',
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

                    const SizedBox(height: 20),
                    // TxnType
                    TextField(
                      readOnly: true,
                      controller: txnTypeController,
                      style: body1.apply(),
                      textInputAction: TextInputAction.next,
                      decoration: InputDecoration(
                        hintText: 'Transaction Type',
                        hintStyle: body1.apply(
                          TextStyle(
                            color: HauberkColors.brightGreen5.withOpacity(0.3),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 60),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: TextButton(
                        onPressed: () async {
                          await txnsColl.add(
                            Transaction(
                              description: descriptionController.text,
                              tags: [tagsController.text],
                              amount: double.parse(amountController.text),
                              fromAccountId: fromAccId,
                              toAccountId: toAccId,
                              txnType: $enumDecode(
                                _$TxnTypeEnumMap,
                                txnTypeController.text.toLowerCase(),
                              ),
                              timestamp: double.parse(timestampController.text),
                            ),
                          );
                        },
                        child: Container(
                          width: 300,
                          height: 60,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: HauberkColors.brightGreen5.withOpacity(0.6),
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
    );
  }

  @override
  void dispose() {
    txnTypeController.dispose();
    timestampController.dispose();
    fromAccController.dispose();
    toAccController.dispose();
    super.dispose();
  }
}
