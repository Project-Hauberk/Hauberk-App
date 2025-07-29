part of 'package:hauberk/main.dart';

final ResponsiveTypeface viewTitle = ViewTitle();
final ResponsiveTypeface heading1 = Heading1();
final ResponsiveTypeface body1 = Body1();

class ViewTitle extends ResponsiveTypeface {
  ViewTitle() {
    styleDelegates.addAll({
      const MobilePlatform(): TextStyle(
        color: HauberkColors.green,
        fontSize: scaled(50, 40),
        fontWeight: FontWeight.w300,
        fontFamily: 'Nunito',
      ),
    });
  }
}

class Heading1 extends ResponsiveTypeface {
  Heading1() {
    styleDelegates.addAll({
      const MobilePlatform(): TextStyle(
        color: HauberkColors.green,
        fontSize: scaled(40, 30),
        fontWeight: FontWeight.w400,
        fontFamily: 'Nunito',
      ),
    });
  }
}

class Body1 extends ResponsiveTypeface {
  Body1() {
    styleDelegates.addAll({
      const MobilePlatform(): TextStyle(
        color: HauberkColors.green,
        fontSize: scaled(18, 24),
        fontWeight: FontWeight.w400,
        fontFamily: 'Nunito',
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
