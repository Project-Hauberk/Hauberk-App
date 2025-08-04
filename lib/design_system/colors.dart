part of 'package:hauberk/main.dart';

enum SemanticCode {
  blue(Color.fromARGB(0, 16, 16, 233)),
  green(Color(0xFF28F704)),
  yellow(Color(0xFFCCA326));

  final Color color;

  const SemanticCode(this.color);
}

class HauberkColors {
  static const darkGreen5 = Color(0xFF050D06);

  static const brightGreen5 = Color(0xFF4DAA57);
  static const brightGreen4 = Color(0xFF19381C);
  static const brightGreen2 = Color(0xFF387B3F);
  static const brightGreen1 = Color(0xFF143C1A);
  static const brightGreen6 = Color(0xFF479E4F);
}
