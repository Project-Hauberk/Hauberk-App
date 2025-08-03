part of 'package:hauberk/main.dart';

final ResponsiveTypeface viewTitle = ViewTitle();
final ResponsiveTypeface heading1 = Heading1();
final ResponsiveTypeface body1 = Body1();
final ResponsiveTypeface body2 = Body2();
final ResponsiveTypeface tableHeader = TableHeader();

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
        fontSize: scaled(26, 22),
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
        color: HauberkColors.brightGreen2,
        fontSize: scaled(16, 14),
        fontWeight: FontWeight.w300,
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

class TableHeader extends ResponsiveTypeface {
  TableHeader() {
    styleDelegates.addAll({
      const MobilePlatform(): TextStyle(
        color: HauberkColors.brightGreen5,
        fontSize: scaled(16, 12),
        fontWeight: FontWeight.w500,
        fontStyle: FontStyle.italic,
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
