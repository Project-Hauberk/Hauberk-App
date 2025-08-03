part of 'package:hauberk/main.dart';

class BudgetingView extends StatelessWidget {
  const BudgetingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HauberkColors.darkGreen5,
      bottomNavigationBar: mobileNavBar(context, 2),
      body: const Center(
        child: Text(
          'Coming soon!',
          style: TextStyle(
            color: HauberkColors.brightGreen5,
          ),
        ),
      ),
    );
  }
}
