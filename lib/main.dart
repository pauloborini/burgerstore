import 'package:burgerstore/core/ui/theme/custom_scroll_behavior.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  final sp = await SharedPreferences.getInstance();
  await Env.instance.load();
  runApp( BurgerApp(sp: sp,));
}

///APP

class BurgerApp extends StatelessWidget {
  final SharedPreferences sp;
  const BurgerApp({super.key, required this.sp});

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
          "/": (context) => StartPage(sp: sp,),
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
