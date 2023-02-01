import 'package:flutter/material.dart';

import 'colors_app.dart';
import 'text_styles.dart';

class AppStyles {
  static AppStyles? _instance;

  AppStyles._();

  static AppStyles get instance {
    _instance ??= AppStyles._();
    return _instance!;
  }

  ButtonStyle get primaryButton => ElevatedButton.styleFrom(
      textStyle: TextStyles.instance.textButtonLabel,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(7),
      ),
      backgroundColor: ColorsApp.instance.primary);
}

extension AppStylesExtension on BuildContext {
  AppStyles get appStyles => AppStyles.instance;
}
