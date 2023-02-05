import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'product_detail_controller.dart';
import 'product_detail_page.dart';

class ProductDetailRoute {
  ProductDetailRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(
            create: (context) => ProductDetailController(),
          )
        ],
        builder: (context, child) {
          final args = ModalRoute.of(context)!.settings.arguments
              as Map<String, dynamic>;
          return ProductDetailPage(
            product: args['product'],
            orderProduct: args['order'],
          );
        },
      );
}
