part of 'package:hauberk/main.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<StatefulWidget> createState() => TransactionsViewState();
}

class TransactionsViewState extends State<TransactionsView> {
  final loadTableFuture = txnsColl.limit(20).get();
  final Map<String, Account> accountsMap = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HauberkColors.darkGreen5,
      bottomNavigationBar: mobileNavBar(context, 1),
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Transactions',
                  style: viewTitle.apply(),
                ),
                Text(
                  'History',
                  style: heading1.apply(),
                ),
                const SizedBox(height: 20),
                FutureBuilder(
                  future: loadTableFuture,
                  builder: (ctx, snapshot) => snapshot.standardHandler(() {
                    final List<TableRow> rows = [
                      TableRow(
                        decoration: BoxDecoration(
                          color: HauberkColors.brightGreen5.withOpacity(0.4),
                        ),
                        children: [
                          TableCell(
                            child: Text(
                              'Description',
                              style: body2.apply(),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'Amount',
                              style: body2.apply(),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'From',
                              style: body2.apply(),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'To',
                              style: body2.apply(),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'Type',
                              style: body2.apply(),
                            ),
                          ),
                          TableCell(
                            child: Text(
                              'Tags',
                              style: body2.apply(),
                            ),
                          ),
                        ],
                      ),
                    ];
                    for (QueryDocumentSnapshot<Transaction> doc
                        in snapshot.data?.docs ?? const []) {
                      final Transaction txn = doc.data();
                      rows.add(
                        TableRow(
                          decoration: BoxDecoration(
                            color: HauberkColors.brightGreen5.withOpacity(0.1),
                          ),
                          children: [
                            TableCell(
                              child: Text(
                                txn.description,
                                style: body2.apply(),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                txn.amount.toStringAsFixed(2),
                                style: body2.apply(),
                              ),
                            ),
                            TableCell(
                              child: txn.fromAccountId == '' ||
                                      accountsMap.containsKey(txn.fromAccountId)
                                  ? Text(
                                      accountsMap[txn.fromAccountId]?.name ??
                                          '--',
                                      style: body2.apply(),
                                    )
                                  : FutureBuilder(
                                      future: (() async {
                                        final data = await accountsColl
                                            .doc(txn.fromAccountId)
                                            .get();
                                        accountsMap[txn.fromAccountId] =
                                            data.data()!;
                                        return data;
                                      })(),
                                      builder: (_, snapshot) =>
                                          snapshot.standardHandler(
                                        () => Text(
                                          snapshot.data?.data()?.name ??
                                              'ERROR',
                                          style: body2.apply(),
                                        ),
                                      ),
                                    ),
                            ),
                            TableCell(
                              child: txn.toAccountId == '' ||
                                      accountsMap.containsKey(txn.toAccountId)
                                  ? Text(
                                      accountsMap[txn.toAccountId]?.name ??
                                          '--',
                                      style: body2.apply(),
                                    )
                                  : FutureBuilder(
                                      future: (() async {
                                        final data = await accountsColl
                                            .doc(txn.toAccountId)
                                            .get();
                                        accountsMap[txn.toAccountId] =
                                            data.data()!;
                                        return data;
                                      })(),
                                      builder: (_, snapshot) =>
                                          snapshot.standardHandler(
                                        () => Text(
                                          snapshot.data?.data()?.name ??
                                              'ERROR',
                                          style: body2.apply(),
                                        ),
                                      ),
                                    ),
                            ),
                            TableCell(
                              child: Text(
                                txn.txnType.name,
                                style: body2.apply(),
                              ),
                            ),
                            TableCell(
                              child: Text(
                                txn.tags.join(', '),
                                style: body2.apply(),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return snapshot.data?.size != 0
                        ? Table(
                            border: TableBorder.all(
                                color: HauberkColors.brightGreen5
                                    .withOpacity(0.7)),
                            columnWidths: const {
                              0: FractionColumnWidth(0.25), // Description
                              2: FractionColumnWidth(0.25), // Amount
                              3: FractionColumnWidth(0.1), // FromAcc
                              4: FractionColumnWidth(0.1), // ToAcc
                              5: FractionColumnWidth(0.1), // TxnType
                              6: FractionColumnWidth(0.15), // Tags
                            },
                            children: rows,
                          )
                        : Center(
                            child: Text(
                              'No data.',
                              style: body1.apply(),
                            ),
                          );
                  }),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 20,
            right: 20,
            child: IconButton(
              onPressed: () async {
                await showGeneralDialog(
                  context: context,
                  transitionDuration: const Duration(milliseconds: 200),
                  pageBuilder: (_, __, ___) => const AddTransactionForm(),
                  barrierDismissible: true,
                  barrierLabel: 'barrier',
                  transitionBuilder: (_, animation, __, child) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: const Offset(0, 1),
                        end: Offset.zero,
                      ).animate(CurvedAnimation(
                          parent: animation, curve: Curves.easeOut)),
                      child: child,
                    );
                  },
                );
              },
              icon: const Icon(
                Icons.add,
                size: 24,
                color: HauberkColors.brightGreen5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
