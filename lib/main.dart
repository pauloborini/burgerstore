import 'package:flutter/material.dart';

import 'app/core/config/env/env.dart';
import 'app/vakinha_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load();
  runApp(const VakinhaApp());
}
