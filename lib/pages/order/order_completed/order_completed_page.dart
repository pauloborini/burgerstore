import 'package:burgerstore/core/ui/helpers/responsive.dart';
import 'package:burgerstore/core/ui/styles/text_styles.dart';
import 'package:burgerstore/core/ui/widgets/delivery_button.dart';
import 'package:flutter/material.dart';

import '../../../generated/assets.dart';

class OrderCompletedPage extends StatelessWidget {
  const OrderCompletedPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Container(
        constraints: const BoxConstraints(maxWidth: 1440),
        child: Column(
          children: [
            const Spacer(
              flex: 3,
            ),
            SizedBox(
              height: context.percentHeight(0.4),
              child: Image.asset(Assets.imagesLogoRounded),
            ),
            const Spacer(),
            Text('Em Breve você receberá a confirmação do seu pedido',
                textAlign: TextAlign.center,
                style: context.textStyles.buttonLabel.copyWith(fontSize: 22)),
            const Spacer(
              flex: 1,
            ),
            Text('Obrigado pela preferência!',
                textAlign: TextAlign.center,
                style: context.textStyles.buttonLabel
                    .copyWith(color: Colors.blue, fontSize: 22)),
            const Spacer(
              flex: 2,
            ),
            DeliveryButton(
                width: context.percentWidth(0.8),
                label: 'PÁGINA INICIAL',
                onPressed: () {
                  Navigator.pop(context);
                }),
            const SizedBox(height: 40),
          ],
        ),
      ),
    ));
  }
}
