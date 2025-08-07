part of 'package:hauberk/main.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      activeTabNum: 4,
      viewLabel: 'Profile',
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
                    builder: (_) =>
                        const AddAccountForm(externalAccount: false),
                  );
                },
                height: 70,
                label: 'Add account',
                prefixIcon: Icons.account_balance,
              ),
              const SizedBox(height: 25),
              WideButton.icon(
                action: () async {
                  await showModalBottomSheet(
                    context: ctx,
                    builder: (_) => const AddAccountForm(externalAccount: true),
                  );
                },
                height: 70,
                label: 'Add external account',
                prefixIcon: Icons.person_add,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
