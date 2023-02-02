import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinhaburger/app/pages/home/home_page.dart';

import '../../repositories/products_repository/products_repository.dart';
import '../../repositories/products_repository/products_repository_impl.dart';
import 'home_controller.dart';

class HomeRoute {
  HomeRoute._();

  static Widget get page => MultiProvider(
        providers: [
          Provider<ProductsRepository>(
              create: (context) => ProductsRepositoryImpl(dio: context.read())),
          Provider(create: (context) => HomeController(context.read())),
        ],
        child: const HomePage(),
      );
}
