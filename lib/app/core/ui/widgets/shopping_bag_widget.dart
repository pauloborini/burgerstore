import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vakinhaburger/app/core/extensions/formatter_extension.dart';
import 'package:vakinhaburger/app/core/ui/helpers/responsive.dart';
import 'package:vakinhaburger/app/core/ui/styles/colors_app.dart';

import '../../../dto/order_product_dto.dart';
import '../styles/text_styles.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;

  const ShoppingBagWidget({super.key, required this.bag});

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('accesstoken')) {
      final loginResult = await navigator.pushNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    var totalBag = bag
        .fold<double>(0.0, (total, element) => total += element.totalPrice)
        .currencyPtBR;
    return Container(
      clipBehavior: Clip.hardEdge,
      padding: const EdgeInsets.all(16),
      height: context.percentHeight(0.11),
      width: double.maxFinite,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black38, blurRadius: 10, blurStyle: BlurStyle.outer)
        ],
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(12), topRight: Radius.circular(12)),
      ),
      child: GestureDetector(
        onTap: () {
          _goOrder(context);
        },
        child: Container(
          decoration: BoxDecoration(
              color: context.colors.primary, borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child:
                      Icon(Icons.shopping_cart_outlined, size: 24, color: Colors.white)),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Ver sacola',
                  textAlign: TextAlign.center,
                  style: TextStyles.instance.textBold
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  totalBag,
                  textAlign: TextAlign.center,
                  style: TextStyles.instance.textBold
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
