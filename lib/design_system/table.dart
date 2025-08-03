part of 'package:hauberk/main.dart';

class HauberkTable extends StatelessWidget {
  final List<String> columnLabels;
  final List<TableRow> rows = [];
  final List<TextAlign> columnAlignments;

  HauberkTable.text({
    required this.columnLabels,
    required List<List<String>> values,
    this.columnAlignments = const [],
    super.key,
  }) {
    final int colCount = columnLabels.length;
    for (int rowNum = 0; rowNum < values.length; rowNum++) {
      final List<Widget> tableCells = [];
      for (int colNum = 0; colNum < colCount; colNum++) {
        tableCells.add(
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 7,
                bottom: 7,
              ),
              child: Text(
                values[rowNum][colNum],
                textAlign: columnAlignments.isNotEmpty
                    ? columnAlignments[colNum]
                    : null,
                style: body1.apply(),
              ),
            ),
          ),
        );
      }
      rows.add(
        TableRow(
          children: tableCells,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<TableCell> colLabels = [];
    if (columnAlignments == const []) {
      colLabels.addAll([
        for (final label in columnLabels)
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 7,
                bottom: 7,
              ),
              child: Text(
                label,
                style: tableHeader.apply(),
              ),
            ),
          ),
      ]);
    } else {
      for (int i = 0; i < columnLabels.length; i++) {
        colLabels.add(
          TableCell(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 15,
                right: 15,
                top: 7,
                bottom: 7,
              ),
              child: Text(
                columnLabels[i],
                textAlign: columnAlignments[i],
                style: tableHeader.apply(),
              ),
            ),
          ),
        );
      }
    }
    return Table(
      border: TableBorder.all(
        color: HauberkColors.brightGreen4,
        borderRadius: BorderRadius.circular(10),
      ),
      children: [
        TableRow(
          decoration: BoxDecoration(
            color: HauberkColors.brightGreen4.withOpacity(0.25),
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(10),
              topRight: Radius.circular(10),
            ),
            border: const Border(
              bottom: BorderSide(color: HauberkColors.brightGreen4),
            ),
          ),
          children: colLabels,
        ),
        ...rows,
      ],
    );
  }
}
