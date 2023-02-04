import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../generated/assets.dart';
import '../core/ui/helpers/responsive.dart';
import '../core/ui/widgets/delivery_button.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Responsive.isTest(context)
        ? const Scaffold(
            backgroundColor: Color(0xFF140E0E),
          )
        : Scaffold(
            backgroundColor: const Color(0xFF140E0E),
            extendBodyBehindAppBar: true,
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
                    const SizedBox(height: 73),
                    DeliveryButton(
                        width: context.percentWidth(0.7),
                        height: 34.12,
                        label: 'ACESSAR',
                        onPressed: () {
                          Navigator.pushReplacementNamed(context, '/home');
                        }),
                    const Spacer(),
                    SizedBox(
                        width: double.maxFinite,
                        child: Image.asset(Assets.imagesLanche, fit: BoxFit.fill)),
                  ],
                ),
              ),
            ),
          );
  }
}
