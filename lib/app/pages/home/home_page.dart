import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinhaburger/app/core/ui/widgets/product_item.dart';
import 'package:vakinhaburger/app/pages/home/home_controller.dart';
import 'package:vakinhaburger/app/pages/home/home_state.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/helpers/responsive.dart';
import '../../core/ui/widgets/base_appbar.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends BaseState<HomePage, HomeController> {
  @override
  onReady() {
    controller.loadProducts();
    return super.onReady();
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isTest(context)
        ? const Scaffold()
        : Scaffold(
            appBar: BaseAppBar(appBar: AppBar()),
            body: Container(
              constraints: const BoxConstraints(maxWidth: 1440),
              child: BlocConsumer<HomeController, HomeState>(
                listener: (context, state) {
                  state.status.matchAny(
                    loading: () => showLoader(),
                    any: () => hideLoader(),
                    error: () {
                      hideLoader();
                      showError(state.errorMessage ?? 'Erro não informado');
                    },
                  );
                },
                buildWhen: (previous, current) => current.status
                    .matchAny(any: () => false, initial: () => true, loaded: () => true),
                builder: (context, state) {
                  return Center(
                      child: Column(
                    children: [
                      Text(state.shoppingBag.length.toString()),
                      Expanded(
                        child: ListView.builder(
                          itemCount: state.products.length,
                          itemBuilder: (context, index) {
                            final product = state.products[index];
                            final orders = state.shoppingBag
                                .where((order) => order.product == product);
                            return ProductItem(
                                product: product,
                                orderProduct: orders.isNotEmpty ? orders.first : null);
                          },
                        ),
                      ),
                    ],
                  ));
                },
              ),
            ));
  }
}
