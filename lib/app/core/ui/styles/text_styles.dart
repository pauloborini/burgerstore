import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get font => 'MPlus1p';

  TextStyle get textLight => TextStyle(fontWeight: FontWeight.w300, fontFamily: font);

  TextStyle get textRegular => TextStyle(fontWeight: FontWeight.w400, fontFamily: font);

  TextStyle get textMedium => TextStyle(fontWeight: FontWeight.w500, fontFamily: font);

  TextStyle get textSemiBold => TextStyle(fontWeight: FontWeight.w600, fontFamily: font);

  TextStyle get textBold => TextStyle(fontWeight: FontWeight.w700, fontFamily: font);

  TextStyle get textXBold => TextStyle(fontWeight: FontWeight.w800, fontFamily: font);

  TextStyle get textButtonLabel => textBold.copyWith(fontSize: 14);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
