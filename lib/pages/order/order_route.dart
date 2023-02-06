import 'package:burgerstore/pages/order/order_controller.dart';
import 'package:burgerstore/repositories/order_repository/order_repository.dart';
import 'package:burgerstore/repositories/order_repository/order_repository_impl.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'order_page.dart';

class OrderRoute {
  OrderRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<OrderRepository>(
              create: (context) => OrderRepositoryImpl(dio: context.read())),
          Provider(create: (context) => OrderController(context.read())),
        ],
        child: const OrderPage(),
      );
}
