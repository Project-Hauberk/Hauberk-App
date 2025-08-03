part of 'package:hauberk/main.dart';

class NavbarButton extends StatelessWidget {
  final VoidCallback action;
  final IconData icon;
  final bool active;
  final double width;
  final double height;

  const NavbarButton({
    required this.action,
    required this.icon,
    required this.active,
    required this.width,
    required this.height,
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: action,
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            Center(
              child: active
                  ? ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (Rect bounds) {
                        return LinearGradient(
                          colors: [
                            HauberkColors.brightGreen5,
                            HauberkColors.brightGreen5.withOpacity(0.02)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ).createShader(bounds);
                      },
                      child: Center(
                        child: Icon(
                          icon,
                          size: height - 80,
                          color: HauberkColors.brightGreen1,
                        ),
                      ),
                    )
                  : Icon(
                      icon,
                      size: height - 80,
                      color: HauberkColors.brightGreen1,
                    ),
            ),
            /*  if (active)
            Positioned(
              bottom: -10,
              left: 0,
              right: 0,
              height: height * 0.2,
              child: Center(
                child: CustomPaint(
                  painter: ActiveLightPainter(width: width - 40),
                ),
              ),
            ), */
          ],
        ),
      ),
    );
  }
}
