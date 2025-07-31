part of 'package:hauberk/main.dart';

class TransactionsView extends StatefulWidget {
  const TransactionsView({super.key});

  @override
  State<StatefulWidget> createState() => TransactionsViewState();
}

class TransactionsViewState extends State<TransactionsView> {
  final loadTableFuture = txnsColl.limit(20).get();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HauberkColors.black,
      bottomNavigationBar: mobileNavBar(context, 1),
      body: Stack(
        children: [
          Positioned.fill(
            child: FutureBuilder(
              future: loadTableFuture,
              builder: (ctx, snapshot) => snapshot.standardHandler(() {
                final List<TableRow> rows = [];
                for (QueryDocumentSnapshot<Transaction> doc
                    in snapshot.data?.docs ?? const []) {
                  final Transaction txn = doc.data();
                  rows.add(
                    TableRow(
                      children: [
                        TableCell(
                          child: Text(txn.description),
                        ),
                        TableCell(
                          child: Text(txn.timestamp.toIso8601String()),
                        ),
                        TableCell(
                          child: Text(txn.amount.toStringAsFixed(2)),
                        ),
                        TableCell(
                          child: Text(txn.fromAccountId),
                        ),
                        TableCell(
                          child: Text(txn.toAccountId),
                        ),
                        TableCell(
                          child: Text(txn.txnType.name),
                        ),
                        TableCell(
                          child: Text(txn.tags.join(', ')),
                        ),
                      ],
                    ),
                  );
                }
                return snapshot.data?.size != 0
                    ? Table(
                        border: TableBorder.all(color: Colors.red),
                        columnWidths: const {
                          0: FractionColumnWidth(0.3), // Description
                          1: FractionColumnWidth(0.1), // Timestamp
                          2: FractionColumnWidth(0.05), // Amount
                          3: FractionColumnWidth(0.1), // FromAcc
                          4: FractionColumnWidth(0.1), // ToAcc
                          5: FractionColumnWidth(0.1), // TxnType
                          6: FractionColumnWidth(0.25), // Tags
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
                color: HauberkColors.green,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
