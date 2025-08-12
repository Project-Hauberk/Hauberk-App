part of 'package:hauberk/main.dart';

class BudgetingView extends StatelessWidget {
  const BudgetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewLabel: 'Budgeting',
      activeTabNum: 2,
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
                    builder: (_) => const RecurringCashflowsForm(),
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
                    builder: (_) => const CreateMonthlyBudgetForm(),
                  );
                },
                height: 70,
                label: 'Create monthly budget',
                prefixIcon: Icons.receipt_long,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
