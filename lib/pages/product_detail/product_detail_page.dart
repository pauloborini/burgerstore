import 'package:auto_size_text/auto_size_text.dart';
import 'package:burgerstore/core/extensions/formatter_extension.dart';
import 'package:burgerstore/core/ui/styles/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/helpers/responsive.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/amount_button.dart';
import '../../core/ui/widgets/base_appbar.dart';
import '../../dto/order_product_dto.dart';
import '../../models/product_model.dart';
import 'product_detail_controller.dart';

class ProductDetailPage extends StatefulWidget {
  final ProductModel product;
  final OrderProductDto? orderProduct;

  const ProductDetailPage(
      {super.key, required this.product, required this.orderProduct});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {

  void _showConfirmDelete(int amount) {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: const Text('Deseja remover o item?'),
            actions: [
              TextButton(
                  style: ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(
                          Colors.red.withOpacity(0.1))),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(
                    'Não',
                    style: context.textStyles.medium
                        .copyWith(fontSize: 19, color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    Navigator.of(context).pop(OrderProductDto(
                        product: widget.product, amount: amount));
                  },
                  child: Text(
                    'Sim',
                    style: context.textStyles.medium
                        .copyWith(fontSize: 19, color: Colors.black),
                  ))
            ],
          );
        });
  }

  @override
  void initState() {
    super.initState();
    final int amount = widget.orderProduct?.amount ?? 1;
    controller.initial(amount, widget.orderProduct != null);
  }

  @override
  Widget build(BuildContext context) {
    return Responsive.isTest(context)
        ? const Scaffold()
        : Scaffold(
            appBar: BaseAppBar(
              appBar: AppBar(),
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back_ios_new),
              ),
            ),
            body: Center(
                child: Container(
                    constraints: const BoxConstraints(maxWidth: 1440),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 20),
                        SizedBox(
                          width: double.maxFinite,
                          height: context.percentHeight(0.4),
                          child: Image.network(
                            widget.product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(widget.product.name,
                              style: context.textStyles.xBold
                                  .copyWith(fontSize: 22)),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SingleChildScrollView(
                              child: AutoSizeText(widget.product.description,
                                  maxLines: 20,
                                  style: context.textStyles.regular
                                      .copyWith(fontSize: 18)),
                            ),
                          ),
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Spacer(),
                            BlocBuilder<ProductDetailController, int>(
                              builder: (context, amount) {
                                return AmountButton(
                                  width: context.percentWidth(0.45),
                                  height: 49,
                                  incrementTap: () => controller.increment(),
                                  decrementTap: () => controller.decrement(),
                                  amount: amount,
                                );
                              },
                            ),
                            const Spacer(),
                            BlocBuilder<ProductDetailController, int>(
                              builder: (context, amount) {
                                return InkWell(
                                  onTap: () {
                                    if (amount == 0) {
                                      _showConfirmDelete(amount);
                                    } else {
                                      Navigator.of(context).pop(OrderProductDto(
                                          product: widget.product,
                                          amount: amount));
                                    }
                                  },
                                  child: AnimatedContainer(
                                      duration:
                                          const Duration(milliseconds: 500),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: amount == 0
                                            ? Colors.red
                                            : context.colors.primary,
                                        borderRadius: BorderRadius.circular(7),
                                      ),
                                      width: context.percentWidth(0.45),
                                      padding: const EdgeInsets.all(12),
                                      height: 49,
                                      child: amount == 0
                                          ? AutoSizeText(
                                              'Remover Item',
                                              textAlign: TextAlign.center,
                                              minFontSize: 12,
                                              maxFontSize: 16,
                                              maxLines: 1,
                                              style: context.textStyles.bold
                                                  .copyWith(
                                                      color: Colors.white,
                                                      fontSize: 16),
                                            )
                                          : Stack(
                                              children: [
                                                Align(
                                                  alignment:
                                                      Alignment.centerLeft,
                                                  child: AutoSizeText(
                                                    'Adicionar',
                                                    minFontSize: 10,
                                                    maxFontSize: 14,
                                                    maxLines: 1,
                                                    style: context
                                                        .textStyles.bold
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                  ),
                                                ),
                                                Align(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: AutoSizeText(
                                                    (widget.product.price *
                                                            amount)
                                                        .currencyPtBR,
                                                    minFontSize: 10,
                                                    maxFontSize: 14,
                                                    maxLines: 1,
                                                    textAlign: TextAlign.center,
                                                    style: context
                                                        .textStyles.bold
                                                        .copyWith(
                                                            color: Colors.white,
                                                            fontSize: 14),
                                                  ),
                                                ),
                                              ],
                                            )),
                                );
                              },
                            ),
                            const Spacer(),
                          ],
                        ),
                        const SizedBox(height: 10)
                      ],
                    ))),
          );
  }
}
