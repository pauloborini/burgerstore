import 'package:flutter/material.dart';

class TextStyles {
  static TextStyles? _instance;

  TextStyles._();

  static TextStyles get instance {
    _instance ??= TextStyles._();
    return _instance!;
  }

  String get font => 'MPlus1p';

  TextStyle get light =>
      TextStyle(fontWeight: FontWeight.w300, fontFamily: font);

  TextStyle get regular =>
      TextStyle(fontWeight: FontWeight.w400, fontFamily: font);

  TextStyle get medium =>
      TextStyle(fontWeight: FontWeight.w500, fontFamily: font);

  TextStyle get semiBold =>
      TextStyle(fontWeight: FontWeight.w600, fontFamily: font);

  TextStyle get bold =>
      TextStyle(fontWeight: FontWeight.w700, fontFamily: font);

  TextStyle get xBold =>
      TextStyle(fontWeight: FontWeight.w800, fontFamily: font);

  TextStyle get buttonLabel => bold.copyWith(fontSize: 14);
}

extension TextStylesExtension on BuildContext {
  TextStyles get textStyles => TextStyles.instance;
}
