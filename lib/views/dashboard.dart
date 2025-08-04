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
      activeTabNum: 0,
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
            () => HauberkTable.text(
              columnLabels: const ['Account', 'Balance'],
              columnAlignments: const [TextAlign.left, TextAlign.right],
              values: [
                for (QueryDocumentSnapshot<Account> doc
                    in snapshot.data?.docs ?? const [])
                  [
                    doc.data().name.toString(),
                    doc.data().balance.toStringAsFixed(2),
                  ]
              ],
            ),
          ),
        ),
        const SizedBox(height: 50),
        Text('Transactions Triage', style: heading1.apply()),
        const SizedBox(height: 25),
        SizedBox(
          height: 120,
          width: MediaQuery.of(context).size.width - 70,
          child: FutureBuilder(
            future: (() async => txnsColl.get())(),
            builder: (ctx, snapshot) => snapshot.standardHandler(
              () => LimitedList<(String amt, String txnDesc)>(
                limit: 3,
                values: [
                  for (QueryDocumentSnapshot<Transaction> txn
                      in snapshot.data?.docs ?? const [])
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
                lastButtonBuilder: (itemCount) => WideButton.noPrefix(
                  action: () {},
                  height: 40,
                  label: 'View all $itemCount transactions',
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
