part of 'package:hauberk/main.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<StatefulWidget> createState() => DashboardViewState();
}

class DashboardViewState extends State<DashboardView> with ViewportScaling {
  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      customViewTitle: FutureBuilder(
        future: profileDoc.get(),
        builder: (ctx, snapshot) => snapshot.standardHandler(
          () => RichText(
            text: TextSpan(
              text: 'Good evening,\n',
              style: viewTitle.apply(),
              children: [
                TextSpan(
                  text: snapshot.data?.data()?.displayName ?? 'user',
                  style: viewTitle
                      .apply(const TextStyle(fontWeight: FontWeight.w600)),
                )
              ],
            ),
          ),
        ),
      ),
      children: [
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
    );
  }
}
