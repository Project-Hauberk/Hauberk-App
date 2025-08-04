part of 'package:hauberk/main.dart';

class TxnCard extends StatelessWidget {
  final SemanticCode semanticCode;
  final Transaction transaction;
  final double width;
  final double height;

  const TxnCard({
    required this.semanticCode,
    required this.transaction,
    required this.width,
    required this.height,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: Stack(
        children: [
          Positioned.fill(
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                color: HauberkColors.brightGreen5.withOpacity(0.1),
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                  color: HauberkColors.brightGreen6.withOpacity(0.1),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          transaction.amount.toStringAsFixed(2),
                          style: card1.apply(
                            TextStyle(color: semanticCode.color),
                          ),
                        ),
                        Text(
                          transaction.timestamp.toString().substring(0, 6),
                          style: body1.apply(
                            const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: HauberkColors.brightGreen5,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FutureBuilder<(String, String)>(
                          future: () async {
                            if (transaction.fromAccountId == null) {
                              return ('Other', '');
                            } else {
                              final res = (await accountsColl
                                      .doc(transaction.fromAccountId)
                                      .get())
                                  .data()!;
                              return (res.name, res.ownerId);
                            }
                          }(),
                          builder: (ctx, snapshot) => snapshot.standardHandler(
                            () => Text(
                              snapshot.data!.$1,
                              style: body1.apply(
                                TextStyle(
                                  fontWeight: (snapshot.data!.$2) == userId
                                      ? FontWeight.w500
                                      : FontWeight.w300,
                                  color: HauberkColors.brightGreen5
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Icon(
                            Icons.arrow_right,
                            size: 20,
                            color: HauberkColors.brightGreen5.withOpacity(0.7),
                          ),
                        ),
                        FutureBuilder<(String, String)>(
                          future: () async {
                            if (transaction.toAccountId == null) {
                              return ('Other', '');
                            } else {
                              final res = (await accountsColl
                                      .doc(transaction.toAccountId)
                                      .get())
                                  .data()!;
                              return (res.name, res.ownerId);
                            }
                          }(),
                          builder: (ctx, snapshot) => snapshot.standardHandler(
                            () => Text(
                              snapshot.data!.$1,
                              style: body1.apply(
                                TextStyle(
                                  fontWeight: (snapshot.data!.$2) == userId
                                      ? FontWeight.w500
                                      : FontWeight.w300,
                                  color: HauberkColors.brightGreen5
                                      .withOpacity(0.7),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    SizedBox(
                      height: 45,
                      child: TextField(
                        style: input1.apply(),
                        decoration: InputDecoration(
                          filled: true,
                          hintStyle: input1.apply(),
                          fillColor:
                              HauberkColors.brightGreen5.withOpacity(0.05),
                          border: InputBorder.none,
                          hintText: transaction.description ??
                              'Describe the transaction',
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ChipButton(
                          editable: false,
                          items: {
                            transaction.txnType.name:
                                txnTypeToCode(transaction.txnType).color
                          },
                        ),
                        if (transaction.tags.isNotEmpty)
                          ChipButton(
                            editable: true,
                            items: {
                              transaction.tags.first:
                                  HauberkColors.brightGreen5.withOpacity(0.7),
                              if (transaction.tags.length > 1)
                                '+${(transaction.tags.length - 1).toString()}':
                                    HauberkColors.brightGreen5.withOpacity(0.7),
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              width: 40,
              height: 40,
              decoration: ShapeDecoration(
                shape: const OvalBorder(),
                color: semanticCode.color.withOpacity(0.2),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
