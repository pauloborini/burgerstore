import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:burgerstore/app/core/ui/styles/text_styles.dart';

import '../styles/app_styles.dart';
import '../styles/colors_app.dart';

class ThemeConfig {
  ThemeConfig._();

  static final _defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(color: Colors.grey.shade400));

  static final theme = ThemeData(
      fontFamily: 'MPlus1p',
      primaryColor: ColorsApp.instance.primary,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsApp.instance.primary,
        primary: ColorsApp.instance.primary,
        secondary: ColorsApp.instance.secondary,
      ),
      backgroundColor: Colors.white,
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          scrolledUnderElevation: 0,
          iconTheme: IconThemeData(color: Colors.black87),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          )),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: TextStyles.instance.textRegular.copyWith(color: Colors.black87),
          errorStyle: TextStyles.instance.textRegular.copyWith(color: Colors.redAccent),
          isDense: false,
          contentPadding: const EdgeInsets.only(left: 20),
          border: _defaultInputBorder,
          enabledBorder: _defaultInputBorder,
          focusedBorder: _defaultInputBorder),
      elevatedButtonTheme:
          ElevatedButtonThemeData(style: AppStyles.instance.primaryButton));
}
