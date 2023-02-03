import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:burgerstore/app/core/provider/app_providers.dart';
import 'package:burgerstore/app/core/ui/theme/theme_config.dart';
import 'package:burgerstore/app/pages/auth/login/login_route.dart';
import 'package:burgerstore/app/pages/home/home_route.dart';
import 'package:burgerstore/app/pages/product_detail/product_detail_route.dart';

import 'pages/start_page.dart';

class BurgerApp extends StatelessWidget {
  const BurgerApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return AppProviders(
      child: MaterialApp(
        title: 'Vakina Burger',
        theme: ThemeConfig.theme,
        debugShowCheckedModeBanner: false,
        initialRoute: "/",
        routes: {
          "/": (context) => const StartPage(),
          "/home": (context) => HomeRoute.page,
          "/product_detail": (context) => ProductDetailRoute.page,
          "/login": (context) => LoginRoute.page,
        },
      ),
    );
  }
}
