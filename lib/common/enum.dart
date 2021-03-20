import 'dart:ui';

enum MUIButtonSize { large, middle, small }
enum MUIShape { circle, round, rectangle }

enum MUIType { primary, normal, danger }

enum MUIColor {
  purple,
  pink,
  gray,
}

extension MUIColorExtension on MUIColor {
  // ignore: missing_return
  Color get color {
    switch (this) {
      case MUIColor.purple:
        return Color.fromRGBO(23, 144, 64, 1);
        break;
      case MUIColor.pink:
        return Color(0xFFFB589B);
        break;
      case MUIColor.gray:
        return Color.fromRGBO(0, 0, 0, 0.3);
        break;
    }
  }
}
