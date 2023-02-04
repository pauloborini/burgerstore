import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'register_controller.dart';
import 'register_page.dart';

class RegisterRoute {
  RegisterRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => RegisterController(context.read())),
        ],
        child: const RegisterPage(),
      );
}
