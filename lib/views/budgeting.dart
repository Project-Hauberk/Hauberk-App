part of 'package:hauberk/main.dart';

class BudgetingView extends StatefulWidget {
  const BudgetingView({super.key});
  @override
  State<StatefulWidget> createState() => BudgetingViewState();
}

class BudgetingViewState extends State<BudgetingView> with AuthGuard {
  final List<QueryDocumentSnapshot<BudgetedEvent>> budgetedEvents = [];
  List<double> expenditurePerEvent = [];
  double totalExpenditure = 0;
  List<bool> overflows = [];
  final List<QueryDocumentSnapshot<Transaction>> unaccountedTxns = [];

  bool hasLoaded = false;
  @override
  Widget build(BuildContext context) {
    return authGuarded(
      builder: (context) => ViewScaffold.single(
        viewLabel: 'Budgeting',
        activeTabNum: 2,
        child: FutureBuilder(
          future: monthlyBudgetsColl.limit(1).get(),
          builder: (ctx, snapshot) => snapshot.standardHandler(
            () => snapshot.data!.size == 0
                ? SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Actions', style: heading1.apply()),
                        const SizedBox(height: 25),
                        Builder(
                          builder: (ctx) => Column(
                            children: [
                              WideButton.icon(
                                action: () async {
                                  await showModalBottomSheet(
                                    context: ctx,
                                    builder: (_) => const AddGoalForm(),
                                  );
                                },
                                height: 70,
                                label: 'Create financial goals',
                                prefixIcon: Icons.track_changes_outlined,
                              ),
                              const SizedBox(height: 25),
                              WideButton.icon(
                                action: () async {
                                  await showModalBottomSheet(
                                    context: ctx,
                                    builder: (_) =>
                                        const RecurringCashflowsForm(),
                                  );
                                },
                                height: 70,
                                label: 'Estimate recurring inflows/outflows',
                                prefixIcon: Icons.payments,
                              ),
                              const SizedBox(height: 25),
                              WideButton.icon(
                                action: () async {
                                  await showModalBottomSheet(
                                    context: ctx,
                                    isScrollControlled: true,
                                    builder: (_) =>
                                        const CreateMonthlyBudgetForm(),
                                  );
                                  setState(() {});
                                },
                                height: 70,
                                label: 'Create monthly budget',
                                prefixIcon: Icons.receipt_long,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : SingleChildScrollView(
                    child: FutureBuilder(
                      future: loadBudgetProgressAndTxns(
                        snapshot.data!.docs.first.data(),
                      ),
                      builder: (ctx, snapshot) => snapshot.standardHandler(
                        () {
                          final List<Widget> budgetedEventWidgets = [];
                          for (int i = 0; i < budgetedEvents.length; i++) {
                            budgetedEventWidgets.addAll([
                              Row(
                                children: [
                                  Text(
                                    budgetedEvents[i].data().name,
                                    style: body1.apply(),
                                  ),
                                  const Spacer(),
                                  Text(
                                    '${expenditurePerEvent[i].toStringAsFixed(2)}/${budgetedEvents[i].data().amount.toStringAsFixed(2)}',
                                    style: body1.apply(),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              LinearProgressIndicator(
                                value: overflows[i]
                                    ? 1
                                    : expenditurePerEvent[i] /
                                        budgetedEvents[i].data().amount,
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(10),
                                backgroundColor: HauberkColors.brightGreen1,
                                color: HauberkColors.brightGreen2,
                              ),
                              const SizedBox(height: 15),
                            ]);
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: Dimensions.width() - 40,
                                child: Row(
                                  children: [
                                    Text(
                                      overflows.every((overflow) => !overflow)
                                          ? 'On Track'
                                          : 'Overspending',
                                      style: body1.apply(),
                                    ),
                                    const Spacer(),
                                    Text(
                                      '${totalExpenditure.toStringAsFixed(2)} spent',
                                      style: body1.apply(),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 50),
                              ...budgetedEventWidgets,
                              const SizedBox(height: 25),
                              Text('Uncategorised', style: heading1.apply()),
                              const SizedBox(height: 25),
                              LimitedList<(String amt, String txnDesc)>(
                                limit: 3,
                                values: [
                                  for (QueryDocumentSnapshot<Transaction> txn
                                      in unaccountedTxns)
                                    (
                                      txn.data().amount.toStringAsFixed(2),
                                      txn.data().description ?? '',
                                    )
                                ],
                                itemBuilder: (data, ctx) => WideButton.string(
                                  action: () {},
                                  height: 40,
                                  label: data.$2,
                                  prefixString: data.$1,
                                ),
                                lastButtonBuilder: (itemCount) =>
                                    WideButton.noPrefix(
                                  highlighted: true,
                                  action: () {
                                    Navigator.of(context)
                                        .pushNamed('/transactions');
                                  },
                                  height: 40,
                                  label: 'View all $itemCount transactions',
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ),
          ),
        ),
      ),
    )(context);
  }

  Future<void> loadBudgetProgressAndTxns(MonthlyBudget budget) async {
    if (hasLoaded) return;
    budgetedEvents.addAll((await budgetedEventsColl
            .where(
              FieldPath.documentId,
              whereIn: budget.budgetedEventIds,
            )
            .get())
        .docs);
    expenditurePerEvent = List.filled(budgetedEvents.length, 0);
    overflows = List.filled(budgetedEvents.length, false);
    for (int i = 0; i < budgetedEvents.length; i++) {
      for (final doc in (await txnsColl
              .where('budgetedEventId', isEqualTo: budgetedEvents[i].id)
              .get())
          .docs) {
        expenditurePerEvent[i] += doc.data().amount;
        totalExpenditure += doc.data().amount;
        if (expenditurePerEvent[i] > budgetedEvents[i].data().amount) {
          overflows[i] = true;
        }
      }
    }
    unaccountedTxns.addAll((await txnsColl
            .where(
              'timestamp',
              isLessThan: budget.end,
              isGreaterThanOrEqualTo: budget.start,
            )
            .where('budgetedEventId', isNull: true)
            .get())
        .docs);
    for (final doc in unaccountedTxns) {
      totalExpenditure += doc.data().amount;
    }
    hasLoaded = true;
  }
}
