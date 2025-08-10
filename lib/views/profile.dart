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
              WideButton.icon(
                action: () async {
                  final account = await GoogleSignIn(
                    scopes: [
                      gsheets.SheetsApi.spreadsheetsScope,
                      gsheets.SheetsApi.driveFileScope,
                    ],
                    clientId: oauthClientId,
                  ).signIn();
                  if (account != null) {
                    final AccessCredentials credentials = AccessCredentials(
                      AccessToken(
                        'Bearer',
                        (await account.authentication).accessToken!,
                        // The underlying SDKs don't provide expiry information, so set an
                        // arbitrary distant-future time.
                        DateTime.now().toUtc().add(const Duration(days: 365)),
                      ),
                      null, // The underlying SDKs don't provide a refresh token.
                      [gsheets.SheetsApi.spreadsheetsScope],
                    );

                    final authClient =
                        authenticatedClient(http.Client(), credentials);
                    if (context.mounted) {
                      await showModalBottomSheet(
                        context: context,
                        builder: (_) => LinkGsheetForm(
                          authClient: authClient,
                        ),
                      );
                    }
                  }
                },
                height: 70,
                label: 'Connect to Google Sheets',
                prefixIcon: Icons.table_chart,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
