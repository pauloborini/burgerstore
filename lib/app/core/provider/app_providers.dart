import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vakinhaburger/app/core/rest_client/custom_dio.dart';
import 'package:vakinhaburger/app/pages/home/home_controller.dart';
import 'package:vakinhaburger/app/pages/product_detail/product_detail_controller.dart';
import 'package:vakinhaburger/app/repositories/products_repository/products_repository.dart';
import 'package:vakinhaburger/app/repositories/products_repository/products_repository_impl.dart';

class AppProviders extends StatelessWidget {
  final Widget child;

  const AppProviders({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => CustomDio()),
        Provider<ProductsRepository>(
            create: (context) => ProductsRepositoryImpl(dio: context.read())),
        Provider(create: (context) => HomeController(context.read())),
        Provider(create: (context) => ProductDetailController()),
      ],
      child: child,
    );
  }
}
