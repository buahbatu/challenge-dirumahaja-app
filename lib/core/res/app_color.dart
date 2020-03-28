import 'package:flutter/material.dart';
import 'package:flutter_color/flutter_color.dart';

extension AppColor on String {
  HexColor toHexColor() {
    return HexColor(this);
  }

  static final titleColor = '0165C0';
  static final bodyColor = '666666';
  static final greyBgColor = 'F5F5F5';

  static final skyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [HexColor('CCE7FF'), HexColor('E7F3FF')],
  );
}
