import 'package:auto_size_text/auto_size_text.dart';
import 'package:burgerstore/core/extensions/formatter_extension.dart';
import 'package:burgerstore/core/ui/helpers/responsive.dart';
import 'package:burgerstore/core/ui/widgets/amount_button.dart';
import 'package:burgerstore/dto/order_product_dto.dart';
import 'package:burgerstore/pages/order/order_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../generated/assets.dart';
import '../styles/text_styles.dart';

class OrderProductItem extends StatelessWidget {
  final int index;
  final OrderProductDto orderProduct;

  const OrderProductItem(
      {super.key, required this.index, required this.orderProduct});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(7),
                child: SizedBox(
                  height: 70,
                  width: 110,
                  child: FadeInImage.assetNetwork(
                      fit: BoxFit.cover,
                      placeholder: Assets.imagesLoading,
                      image: orderProduct.product.image),
                ),
              ),
              Expanded(
                flex: 2,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: context.percentWidth(0.59),
                            child: AutoSizeText(orderProduct.product.name,
                                maxLines: 2,
                                maxFontSize: 16,
                                minFontSize: 10,
                                style: context.textStyles.medium
                                    .copyWith(fontSize: 16)),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AutoSizeText(
                              (orderProduct.amount * orderProduct.product.price)
                                  .currencyPtBR,
                              style: context.textStyles.bold
                                  .copyWith(fontSize: 16)),
                          AmountButton(
                            isLittle: true,
                            amount: orderProduct.amount,
                            incrementTap: () {
                              context.read<OrderController>().incrementProduct(index);
                            },
                            decrementTap: () {},
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          const Divider(
            thickness: 1,
          ),
        ],
      ),
    );
  }
}
