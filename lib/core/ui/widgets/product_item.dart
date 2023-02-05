import 'package:auto_size_text/auto_size_text.dart';
import 'package:burgerstore/core/extensions/formatter_extension.dart';
import 'package:burgerstore/core/ui/styles/colors_app.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../generated/assets.dart';
import '../../../dto/order_product_dto.dart';
import '../../../models/product_model.dart';
import '../../../pages/home/home_controller.dart';
import '../helpers/responsive.dart';
import '../styles/text_styles.dart';

class ProductItem extends StatelessWidget {
  final ProductModel product;
  final OrderProductDto? orderProduct;

  const ProductItem({super.key, required this.product, required this.orderProduct});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final controller = context.read<HomeController>();
        final orderProductResult = await Navigator.of(context)
            .pushNamed('/product_detail', arguments: {'product': product, 'order': orderProduct});
        if (orderProductResult != null) {
          controller.crudBag(orderProductResult as OrderProductDto);
        }
      },
      child: Container(
        decoration: const BoxDecoration(boxShadow: [
          BoxShadow(
            offset: Offset(0.0, 8.0),
            blurRadius: 5,
            color: Color.fromRGBO(0, 0, 0, 0.05),
          )
        ]),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(7)),
          elevation: 8,
          child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 15),
              height: 150,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        SizedBox(
                          // width: context.percentWidth(0.45),
                          child: AutoSizeText(product.name,
                              minFontSize: 12,
                              maxLines: 2,
                              style: context.textStyles.xBold.copyWith(fontSize: 16)),
                        ),
                        const Spacer(),
                        SizedBox(
                          // width: context.percentWidth(0.5),
                          child: AutoSizeText(
                            product.description,
                            minFontSize: 11,
                            style: context.textStyles.regular.copyWith(fontSize: 14),
                            maxLines: 4,
                          ),
                        ),
                        const Spacer(),
                        Text(product.price.currencyPtBR,
                            style: context.textStyles.bold
                                .copyWith(fontSize: 16, color: context.colors.secondary)),
                        const Spacer(),
                      ],
                    ),
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(7),
                    child: SizedBox(
                      width: Responsive.isSmalless(context) ? 120 : 150,
                      height: 100,
                      child: FadeInImage.assetNetwork(
                        placeholder: Assets.imagesLoading,
                        fit: BoxFit.cover,
                        image: product.image,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
