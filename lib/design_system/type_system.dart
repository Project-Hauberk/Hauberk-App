part of 'package:hauberk/main.dart';

final ResponsiveTypeface viewTitle = ViewTitle();
final ResponsiveTypeface heading1 = Heading1();
final ResponsiveTypeface body1 = Body1();
final ResponsiveTypeface body2 = Body2();

class ViewTitle extends ResponsiveTypeface {
  ViewTitle() {
    styleDelegates.addAll({
      const MobilePlatform(): TextStyle(
        color: HauberkColors.brightGreen5,
        fontSize: scaled(36, 33),
        fontWeight: FontWeight.w300,
        fontFamily: 'Rubik',
      ),
    });
  }
}

class Heading1 extends ResponsiveTypeface {
  Heading1() {
    styleDelegates.addAll({
      const MobilePlatform(): TextStyle(
        color: HauberkColors.brightGreen5,
        fontSize: scaled(34, 28),
        fontWeight: FontWeight.w500,
        fontFamily: 'Rubik',
      ),
    });
  }
}

class Body1 extends ResponsiveTypeface {
  Body1() {
    styleDelegates.addAll({
      const MobilePlatform(): TextStyle(
        color: HauberkColors.brightGreen5,
        fontSize: scaled(18, 14),
        fontWeight: FontWeight.w400,
        fontFamily: 'Rubik',
      ),
    });
  }
}

class Body2 extends ResponsiveTypeface {
  Body2() {
    styleDelegates.addAll({
      const MobilePlatform(): TextStyle(
        color: HauberkColors.brightGreen5,
        fontSize: scaled(10, 14),
        fontWeight: FontWeight.w300,
        fontFamily: 'Rubik',
      ),
    });
  }
}

class MobilePlatform extends DetectedPlatform {
  const MobilePlatform()
      : super(
          'mobile',
          baseWidth: 400,
          baseHeight: 700,
        );
}
