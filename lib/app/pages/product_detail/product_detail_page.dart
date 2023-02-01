import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vakinhaburger/app/core/extensions/formatter_extension.dart';
import 'package:vakinhaburger/app/core/ui/base_state/base_state.dart';
import 'package:vakinhaburger/app/core/ui/styles/colors_app.dart';
import 'package:vakinhaburger/app/core/ui/widgets/base_appbar.dart';
import 'package:vakinhaburger/app/dto/order_product_dto.dart';
import 'package:vakinhaburger/app/models/product_model.dart';
import 'package:vakinhaburger/app/pages/product_detail/product_detail_controller.dart';

import '../../core/ui/helpers/responsive.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/amount_button.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState
    extends BaseState<ProductDetailPage, ProductDetailController> {
  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final OrderProductDto? orderProduct = args['order'];
    final ProductModel product = args['product'];
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
                            product.image,
                            fit: BoxFit.cover,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Text(product.name,
                              style:
                                  TextStyles.instance.textXBold.copyWith(fontSize: 22)),
                        ),
                        const SizedBox(height: 5),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: SingleChildScrollView(
                              child: AutoSizeText(product.description,
                                  maxLines: 20,
                                  style: TextStyles.instance.textRegular
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
                                    Navigator.of(context).pop(OrderProductDto(
                                        product: product, amount: amount));
                                  },
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: context.colors.primary,
                                      borderRadius: BorderRadius.circular(7),
                                    ),
                                    width: context.percentWidth(0.45),
                                    padding: const EdgeInsets.all(8),
                                    height: 49,
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        AutoSizeText(
                                          'Adicionar',
                                          minFontSize: 10,
                                          maxFontSize: 14,
                                          maxLines: 1,
                                          style: TextStyles.instance.textBold
                                              .copyWith(color: Colors.white),
                                        ),
                                        const Spacer(),
                                        Expanded(
                                          flex: 4,
                                          child: AutoSizeText(
                                            (product.price * amount).currencyPtBR,
                                            minFontSize: 10,
                                            maxFontSize: 14,
                                            maxLines: 1,
                                            textAlign: TextAlign.center,
                                            style: TextStyles.instance.textBold
                                                .copyWith(color: Colors.white),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
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
