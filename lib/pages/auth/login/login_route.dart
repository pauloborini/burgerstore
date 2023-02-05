import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'login_controller.dart';
import 'login_page.dart';

class LoginRoute {
  LoginRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
              create: (context) =>
                  LoginController(authRepository: context.read())),
        ],
        child: const LoginPage(),
      );
}
