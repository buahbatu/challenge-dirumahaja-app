import 'package:flutter_color/flutter_color.dart';

extension AppColor on String {
  HexColor toHexColor() {
    return HexColor(this);
  }

  static final titleColor = '0165C0';
  static final bodyColor = '00000099';
}
