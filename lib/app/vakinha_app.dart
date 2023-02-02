import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:vakinhaburger/app/core/provider/app_providers.dart';
import 'package:vakinhaburger/app/core/ui/theme/theme_config.dart';
import 'package:vakinhaburger/app/pages/home/home_page.dart';
import 'package:vakinhaburger/app/pages/home/home_route.dart';
import 'package:vakinhaburger/app/pages/product_detail/product_detail_route.dart';

import 'pages/start_page.dart';

class VakinhaApp extends StatelessWidget {
  const VakinhaApp({super.key});

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
        },
      ),
    );
  }
}
