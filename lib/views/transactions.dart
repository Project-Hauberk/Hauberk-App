part of 'package:hauberk/main.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<StatefulWidget> createState() => TransactionsViewState();
}

class TransactionsViewState extends State<TransactionsView> {
  final List<QueryDocumentSnapshot<Transaction>> transactions = [];
  final Future<QuerySnapshot<Transaction>> query =
      txnsColl.orderBy('timestamp', descending: true).limit(4).get();

  @override
  Widget build(BuildContext context) {
    return ViewScaffold(
      viewLabel: 'Transactions',
      activeTabNum: 1,
      children: [
        SizedBox(
          width: Dimensions.width(),
          height: 220,
          child: FutureBuilder(
            future: () async {
              if (transactions.isEmpty) {
                transactions.addAll((await query).docs);
              } else {
                transactions.addAll((await txnsColl
                        .orderBy('timestamp', descending: true)
                        .limit(4)
                        .startAfter([transactions.last.data()]).get())
                    .docs);
              }
              return transactions;
            }(),
            builder: (ctx, snapshot) => snapshot.standardHandler(
              () => SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    for (final doc in transactions) ...[
                      TxnCard(
                        semanticCode: SemanticCode.green,
                        transaction: doc.data(),
                        width: 400,
                        height: 220,
                      ),
                      const SizedBox(width: 25),
                    ]
                  ],
                ),
              ),
            ),
          ),
        ),
        const SizedBox(height: 25),
        Text('Actions', style: heading1.apply()),
        const SizedBox(height: 25),
        Builder(
          builder: (ctx) => Column(
            children: [
              WideButton.icon(
                action: () async {
                  await showModalBottomSheet(
                    context: ctx,
                    builder: (_) => const AddTransactionForm(),
                  );
                },
                height: 70,
                label: 'Add transaction manually',
                prefixIcon: Icons.add,
              ),
              const SizedBox(height: 25),
              WideButton.icon(
                action: () {},
                height: 70,
                label: 'Create split payment',
                prefixIcon: Icons.call_split,
              ),
              const SizedBox(height: 25),
              WideButton.icon(
                action: () {},
                height: 70,
                label: 'Scan a receipt/bill',
                prefixIcon: Icons.document_scanner,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
