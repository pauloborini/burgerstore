import 'package:flutter/material.dart';

import 'app/burger_app.dart';
import 'app/core/config/env/env.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load();
  runApp(const BurgerApp());
}
