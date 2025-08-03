part of 'package:hauberk/main.dart';

class BudgetingView extends StatelessWidget {
  const BudgetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewLabel: 'Budgeting',
      children: [
        Text('Actions', style: heading1.apply()),
        const SizedBox(height: 25),
        Column(
          children: [
            WideButton.icon(
              action: () {},
              height: 70,
              label: 'Create financial goals',
              prefixIcon: Icons.track_changes_outlined,
            ),
            const SizedBox(height: 25),
            WideButton.icon(
              action: () {},
              height: 70,
              label: 'Estimate inflows/outflows',
              prefixIcon: Icons.payments,
            ),
            const SizedBox(height: 25),
            WideButton.icon(
              action: () {},
              height: 70,
              label: 'Create monthly budget',
              prefixIcon: Icons.receipt_long,
            ),
          ],
        ),
      ],
    );
  }
}
