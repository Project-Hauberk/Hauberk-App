part of 'package:hauberk/main.dart';

class CreateMonthlyBudgetForm extends StatefulWidget {
  const CreateMonthlyBudgetForm({super.key});

  @override
  State<StatefulWidget> createState() => CreateMonthlyBudgetFormState();
}

class CreateMonthlyBudgetFormState extends State<CreateMonthlyBudgetForm> {
  final List<QueryDocumentSnapshot<RecurrentCashflow>> recurringCashflows = [];
  final Map<String, (QueryDocumentSnapshot<Account>, double)> savingsAccounts =
      {};
  final List<BudgetedEvent> budgetedEvents = [];
  bool queried = false;
  double postStashAmt = 0;

  Future<void> loadData() async {
    if (queried) return;

    recurringCashflows.addAll(
        (await recurrentCashflowsColl.orderBy('amount', descending: true).get())
            .docs);
    savingsAccounts.addAll({
      for (final doc in (await accountsColl
              .where(
                FieldPath.documentId,
                whereIn: (await profileDoc.get()).data()!.savingsAccountIds,
              )
              .get())
          .docs)
        doc.id: (doc, 0)
    });

    queried = true;
  }

  double computeUnallocatedBalance(
      List<QueryDocumentSnapshot<RecurrentCashflow>>
          selectedRecurrentCashflows) {
    double res = selectedRecurrentCashflows[0].data().amount;
    for (final doc in selectedRecurrentCashflows.skip(1)) {
      res += doc.data().amount;
    }
    postStashAmt = res;
    for (final entry in savingsAccounts.entries) {
      if (entry.value.$2 > 0) {
        res -= entry.value.$2 * postStashAmt;
      }
    }
    for (final event in budgetedEvents) {
      res -= event.amount;
    }

    return res;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      onClosing: () {},
      builder: (ctx) => Container(
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
          child: Theme(
            data: Theme.of(context).copyWith(
              sliderTheme: const SliderThemeData(
                activeTrackColor: HauberkColors.brightGreen2,
                inactiveTrackColor: HauberkColors.brightGreen1,
                thumbColor: HauberkColors.brightGreen2,
              ),
            ),
            child: SizedBox(
              width: Dimensions.width(),
              height: Dimensions.height() * 0.7,
              child: FutureBuilder(
                future: loadData(),
                builder: (ctx, snapshot) => Stack(
                  children: [
                    Positioned.fill(
                      bottom: 80,
                      child: SingleChildScrollView(
                        child: SizedBox(
                          width: Dimensions.width() * 0.7,
                          child: Column(
                            children: [
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Recurring Cashflows',
                                  textAlign: TextAlign.left,
                                  style: heading1.apply(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                height: 180,
                                child: SingleChildScrollView(
                                  child: Column(
                                    children: [
                                      for (QueryDocumentSnapshot<
                                              RecurrentCashflow> doc
                                          in recurringCashflows)
                                        WideButton.string(
                                          action: () {},
                                          height: 40,
                                          label: doc.data().name,
                                          prefixString: doc
                                              .data()
                                              .amount
                                              .toStringAsFixed(2),
                                        ),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Savings',
                                  textAlign: TextAlign.left,
                                  style: heading1.apply(),
                                ),
                              ),
                              ...[
                                for ((
                                  QueryDocumentSnapshot<Account>,
                                  double
                                ) entry in savingsAccounts.values) ...[
                                  const SizedBox(height: 20),
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            entry.$1.data().name,
                                            style: body1.apply(),
                                          ),
                                          const Spacer(),
                                          Text(
                                            (entry.$2 * postStashAmt)
                                                .toStringAsFixed(2),
                                            style: body1.apply(),
                                          ),
                                        ],
                                      ),
                                      Slider(
                                        value: savingsAccounts[entry.$1.id]!.$2,
                                        onChanged: (fraction) {
                                          setState(() {
                                            savingsAccounts[entry.$1.id] =
                                                (entry.$1, fraction);
                                          });
                                        },
                                      ),
                                    ],
                                  ),
                                ]
                              ],
                              const SizedBox(height: 20),
                              SizedBox(
                                width: double.infinity,
                                child: Text(
                                  'Budgeted Events',
                                  textAlign: TextAlign.left,
                                  style: heading1.apply(),
                                ),
                              ),
                              const SizedBox(height: 20),
                              ...[
                                for (final budgetedEvent in budgetedEvents)
                                  WideButton.string(
                                    action: () {},
                                    height: 80,
                                    label: budgetedEvent.name,
                                    prefixString:
                                        budgetedEvent.amount.toStringAsFixed(2),
                                  ),
                                WideButton.icon(
                                  action: () async {
                                    // await the budgeted event bottomsheet
                                    // add to list
                                    // set state
                                  },
                                  height: 80,
                                  label: 'Add new event',
                                  prefixIcon: Icons.add,
                                ),
                              ],
                              const SizedBox(height: 60),
                              SizedBox(
                                width: 300,
                                height: 60,
                                child: TextButton(
                                  onPressed: () async {
                                    if (context.mounted) {
                                      Navigator.of(context).pop();
                                    }
                                  },
                                  child: Container(
                                    width: 300,
                                    height: 60,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: HauberkColors.brightGreen5
                                          .withOpacity(0.2),
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
                              const SizedBox(height: 25),
                            ],
                          ),
                        ),
                      ),
                    ),
                    if (recurringCashflows.isNotEmpty)
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        height: 80,
                        child: Container(
                          decoration: const BoxDecoration(
                            color: HauberkColors.darkGreen5,
                            border: Border(
                              top: BorderSide(
                                color: HauberkColors.brightGreen5,
                              ),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20),
                            child: RichText(
                              text: TextSpan(
                                text: computeUnallocatedBalance(
                                        recurringCashflows)
                                    .toStringAsFixed(2),
                                style: body1.apply(
                                  const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                children: [
                                  TextSpan(
                                    text: ' unallocated balance',
                                    style: body1.apply(),
                                  ),
                                ],
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
}
