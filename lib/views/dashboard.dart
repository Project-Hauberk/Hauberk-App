part of 'package:hauberk/main.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<StatefulWidget> createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> with ViewportScaling {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: HauberkColors.black,
        bottomNavigationBar: mobileNavBar(context),
        body: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Dashboard',
                style: viewTitle.apply(),
              ),
              Text(
                'Balances',
                style: heading1.apply(),
              ),
              const SizedBox(height: 20),
              FutureBuilder(
                future: (() async => accountsColl.get())(),
                builder: (ctx, snapshot) => snapshot.standardHandler(
                  () => Text(
                    [
                      for (QueryDocumentSnapshot<Account> doc
                          in snapshot.data?.docs ?? const [])
                        "${doc.data().name}: ${doc.data().balance}"
                    ].join('\n'),
                    style: body1.apply(),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
