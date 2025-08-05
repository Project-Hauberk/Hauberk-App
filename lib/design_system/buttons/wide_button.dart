part of 'package:hauberk/main.dart';

class WideButton extends StatefulWidget {
  final double height;
  final String? prefixString;
  final IconData? prefixIcon;
  final String label;
  final VoidCallback action;
  final bool highlighted;

  const WideButton.icon({
    required this.action,
    required this.height,
    required this.label,
    this.highlighted = false,
    required IconData prefixIcon,
    super.key,
  })  : this.prefixIcon = prefixIcon,
        prefixString = null;

  const WideButton.string({
    required this.action,
    required this.height,
    required this.label,
    this.highlighted = false,
    required String prefixString,
    super.key,
  })  : prefixIcon = null,
        this.prefixString = prefixString;

  const WideButton.noPrefix({
    required this.action,
    required this.height,
    required this.label,
    this.highlighted = false,
    super.key,
  })  : prefixIcon = null,
        prefixString = null;

  @override
  State<StatefulWidget> createState() => WideButtonState();
}

class WideButtonState extends State<WideButton> {
  bool pressing = false;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.action,
      onTapDown: (_) => setState(() => pressing = true),
      onTapUp: (_) => setState(() => pressing = false),
      child: Container(
        width: double.infinity,
        height: widget.height,
        decoration: BoxDecoration(
          border: Border.all(color: HauberkColors.brightGreen4),
          borderRadius: BorderRadius.circular(10),
          color: pressing
              ? HauberkColors.brightGreen5.withOpacity(0.1)
              : widget.highlighted
                  ? HauberkColors.brightGreen5.withOpacity(0.7)
                  : null,
        ),
        child: Row(
          children: [
            if (widget.prefixIcon != null || widget.prefixString != null) ...[
              Padding(
                padding: const EdgeInsets.only(
                  left: 10,
                  right: 10,
                  top: 7,
                  bottom: 7,
                ),
                child: widget.prefixIcon == null
                    ? Text(
                        widget.prefixString!,
                        style: body1.apply(),
                      )
                    : Icon(
                        widget.prefixIcon!,
                        size: widget.height - 24,
                        color: HauberkColors.brightGreen2,
                      ),
              ),
              const VerticalDivider(
                thickness: 1,
                color: HauberkColors.brightGreen4,
              ),
            ],
            Padding(
              padding: const EdgeInsets.only(
                left: 10,
                right: 10,
                top: 7,
                bottom: 7,
              ),
              child: Text(
                widget.label,
                style: body1.apply(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
