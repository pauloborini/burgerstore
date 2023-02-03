import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinhaburger/app/pages/auth/login/login_page.dart';

class LoginRoute {
  LoginRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => Object()),
        ],
        child: const LoginPage(),
      );
}
