import 'package:burgerstore/pages/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_page.dart';

class OrderRoute {
  OrderRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider(create: (context) => OrderController()),
        ],
        child: const OrderPage(),
      );
}
