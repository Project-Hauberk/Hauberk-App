part of 'package:hauberk/main.dart';

class ChipButton extends StatefulWidget {
  final Map<String, Color> items;
  final bool editable;

  const ChipButton({
    required this.items,
    required this.editable,
    super.key,
  });

  @override
  State<StatefulWidget> createState() => ChipButtonState();
}

class ChipButtonState extends State<ChipButton> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        buildChip(context, widget.items.entries.first),
      ],
    );
  }

  Widget buildChip(BuildContext context, MapEntry<String, Color> item) =>
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2),
          color: item.value.withOpacity(0.15),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 6, right: 6, top: 4, bottom: 4),
          child: Text(
            item.key,
            style: button1.apply(
              TextStyle(color: item.value),
            ),
          ),
        ),
      );
}
