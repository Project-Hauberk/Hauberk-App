part of 'package:hauberk/main.dart';

class ViewScaffold extends StatelessWidget {
  final String? viewLabel;
  final Widget? customViewTitle;
  final Widget? singleChild;
  final List<Widget>? multipleChildren;

  const ViewScaffold.single({
    required Widget child,
    this.viewLabel,
    this.customViewTitle,
    super.key,
  })  : singleChild = child,
        multipleChildren = const [];

  const ViewScaffold({
    required List<Widget> children,
    this.viewLabel,
    this.customViewTitle,
    super.key,
  })  : singleChild = null,
        multipleChildren = children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HauberkColors.darkGreen5,
      body: Stack(
        children: [
          Positioned.fill(
            child: Padding(
              padding: const EdgeInsets.only(
                top: 25,
                left: 20,
                right: 20,
                bottom: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (viewLabel != null)
                    Text(viewLabel!, style: viewTitle.apply()),
                  if (customViewTitle != null) customViewTitle!,
                  const SizedBox(height: 50),
                  if (singleChild != null) singleChild!,
                  if (multipleChildren != null) ...multipleChildren!,
                ],
              ),
            ),
          ),
          /* Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            height: 62,
            child: MobileNavBar(),
          ), */
        ],
      ),
    );
  }
}
