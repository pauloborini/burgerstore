import 'package:burgerstore/core/extensions/formatter_extension.dart';
import 'package:burgerstore/core/ui/helpers/responsive.dart';
import 'package:burgerstore/core/ui/styles/colors_app.dart';
import 'package:burgerstore/pages/home/home_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../dto/order_product_dto.dart';
import '../styles/text_styles.dart';

class ShoppingBagWidget extends StatelessWidget {
  final List<OrderProductDto> bag;

  const ShoppingBagWidget({super.key, required this.bag});

  Future<void> _goOrder(BuildContext context) async {
    final navigator = Navigator.of(context);
    final controller = context.read<HomeController>();
    final sp = await SharedPreferences.getInstance();
    if (!sp.containsKey('access_token')) {
      final loginResult = await navigator.pushNamed('/login');
      if (loginResult == null || loginResult == false) {
        return;
      }
    }
    final updateBag = await navigator.pushNamed('/order', arguments: bag);
    controller.updateBag(updateBag as List<OrderProductDto>);
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
          BoxShadow(
              color: Colors.black38, blurRadius: 10, blurStyle: BlurStyle.outer)
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
              color: context.colors.primary,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Stack(
            children: [
              const Align(
                  alignment: Alignment.centerLeft,
                  child: Icon(Icons.shopping_cart_outlined,
                      size: 24, color: Colors.white)),
              Align(
                alignment: Alignment.center,
                child: Text(
                  'Ver sacola',
                  textAlign: TextAlign.center,
                  style: context.textStyles.bold
                      .copyWith(fontSize: 16, color: Colors.white),
                ),
              ),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  totalBag,
                  textAlign: TextAlign.center,
                  style: context.textStyles.bold
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
