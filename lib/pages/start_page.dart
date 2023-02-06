import 'package:burgerstore/core/ui/styles/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../generated/assets.dart';
import '../core/ui/helpers/responsive.dart';
import '../core/ui/widgets/delivery_button.dart';

class StartPage extends StatefulWidget {
  final SharedPreferences sp;

  const StartPage({Key? key, required this.sp}) : super(key: key);

  @override
  State<StartPage> createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> {
  @override
  Widget build(BuildContext context) {
    return Responsive.isTest(context)
        ? const Scaffold(
            backgroundColor: Color(0xFF140E0E),
          )
        : Scaffold(
            backgroundColor: const Color(0xFF140E0E),
            extendBodyBehindAppBar: false,
            appBar: AppBar(
              toolbarHeight: 0,
              backgroundColor: Colors.transparent,
              systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarIconBrightness: Brightness.light,
                  statusBarColor: Colors.transparent),
            ),
            body: Center(
              child: SizedBox(
                width: double.maxFinite,
                height: context.screenHeight,
                child: Column(
                  children: [
                    const Spacer(),
                    SizedBox(
                        height: context.percentHeight(0.3),
                        child: Image.asset(Assets.imagesLogo)),
                    const Spacer(),

                    DeliveryButton(
                        width: context.percentWidth(0.7),
                        height: 34.12,
                        label: 'ACESSAR',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        }),
                    const SizedBox(height: 20),
                    DeliveryButton(
                        color: !widget.sp.containsKey('access_token')
                            ? context.colors.primary
                            : Colors.blueAccent,
                        width: context.percentWidth(0.7),
                        height: 34.12,
                        label: !widget.sp.containsKey('access_token')
                            ? 'EFETUAR LOGIN'
                            : 'USUÁRIO LOGADO',
                        onPressed: () async {
                          if (!widget.sp.containsKey('access_token')) {
                            Navigator.pushNamed(context, '/login')
                                .then((value) {
                              if (value = true) {
                                setState(() {});
                              }
                            });
                          }
                        }),
                    const Spacer(),

                    SizedBox(
                        width: double.maxFinite,
                        child:
                            Image.asset(Assets.imagesLanche, fit: BoxFit.fill)),
                  ],
                ),
              ),
            ),
          );
  }
}
