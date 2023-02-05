import 'package:burgerstore/core/ui/theme/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'core/config/env/env.dart';
import 'core/provider/app_providers.dart';
import 'core/ui/theme/theme_config.dart';
import 'pages/auth/login/login_route.dart';
import 'pages/auth/register/register_route.dart';
import 'pages/home/home_route.dart';
import 'pages/order/order_route.dart';
import 'pages/product_detail/product_detail_route.dart';
import 'pages/start_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Env.instance.load();
  runApp(const BurgerApp());
}

///APP

class BurgerApp extends StatelessWidget {
  const BurgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return AppProviders(
      child: MaterialApp(
        scrollBehavior: MyCustomScrollBehavior(),
        title: 'Vakinha Burger',
        theme: ThemeConfig.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const StartPage(),
          "/home": (context) => HomeRoute.page,
          "/product_detail": (context) => ProductDetailRoute.page,
          "/login": (context) => LoginRoute.page,
          "/register": (context) => RegisterRoute.page,
          "/order": (context) => OrderRoute.page,
        },
      ),
    );
  }
}
