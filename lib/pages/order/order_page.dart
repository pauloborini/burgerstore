import 'package:burgerstore/core/extensions/formatter_extension.dart';
import 'package:burgerstore/core/ui/styles/colors_app.dart';
import 'package:burgerstore/models/payment_type_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:validatorless/validatorless.dart';

import '../../core/ui/base_state/base_state.dart';
import '../../core/ui/styles/text_styles.dart';
import '../../core/ui/widgets/base_appbar.dart';
import '../../core/ui/widgets/delivery_button.dart';
import '../../core/ui/widgets/order_field.dart';
import '../../core/ui/widgets/order_product_item.dart';
import '../../core/ui/widgets/payment_types_field.dart';
import '../../dto/order_product_dto.dart';
import 'order_controller.dart';
import 'order_state.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends BaseState<OrderPage, OrderController> {
  final addressEC = TextEditingController();
  final documentEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? paymentTypeId;
  bool paymentSelected = false;

  @override
  void dispose() {
    addressEC.dispose();
    documentEC.dispose();
    super.dispose();
  }

  @override
  onReady() {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.loadProducts(products);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            loaded: () => hideLoader(),
            error401: () {
              hideLoader();
              showInfo('Conexão Expirou, efetue novamente o Login');
            },
            errorLoading: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro ao carregar página');
            });
      },
      child: Scaffold(
        appBar: BaseAppBar(
          appBar: AppBar(),
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            icon: const Icon(Icons.arrow_back_ios_new),
          ),
        ),
        body: Container(
          constraints: const BoxConstraints(maxWidth: 1440),
          padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
          child:
              BlocSelector<OrderController, OrderState, List<OrderProductDto>>(
            selector: (state) {
              return state.orderProducts;
            },
            builder: (context, orderProduct) {
              var totalBag = orderProduct
                  .fold<double>(
                      0.0, (total, element) => total += element.totalPrice)
                  .currencyPtBR;

              return Form(
                key: _formKey,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Row(
                        children: [
                          Text(
                            'Carrinho',
                            style:
                                context.textStyles.xBold.copyWith(fontSize: 28),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.red,
                              ))
                        ],
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                          childCount: orderProduct.length, (context, index) {
                        return Column(
                          children: [
                            const SizedBox(height: 10),
                            OrderProductItem(
                              index: index,
                              orderProduct: orderProduct.elementAt(index),
                            )
                          ],
                        );
                      }),
                    ),
                    SliverToBoxAdapter(
                      child: Column(
                        children: [
                          Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text('Total do pedido',
                                    style: context.textStyles.bold
                                        .copyWith(fontSize: 16)),
                                Text(totalBag,
                                    style: context.textStyles.xBold.copyWith(
                                        fontSize: 20,
                                        color: context.colors.secondary)),
                              ]),
                          const Divider(
                            thickness: 1,
                            color: Colors.grey,
                          ),
                          OrderField(
                            title: 'Endereço de Entrega',
                            controller: addressEC,
                            validator:
                                Validatorless.required('Endereço Obrigatório'),
                            hintText: 'Digite o endereço',
                            keyboardType: TextInputType.text,
                          ),
                          const SizedBox(height: 10),
                          OrderField(
                            title: 'CPF',
                            controller: documentEC,
                            validator:
                                Validatorless.required('CPF Obrigatório'),
                            hintText: 'Digite o CPF',
                            keyboardType: TextInputType.number,
                          ),
                          SizedBox(
                            width: double.maxFinite,
                            child: BlocSelector<OrderController, OrderState,
                                List<PaymentTypeModel>>(
                              selector: (state) => state.paymentTypes,
                              builder: (context, paymentTypes) {
                                return PaymentTypesField(
                                  valid: paymentSelected,
                                  paymentsType: paymentTypes,
                                  valueChanged: (value) {
                                    paymentTypeId = value;
                                    paymentSelected = true;
                                  },
                                );
                              },
                            ),
                          )
                        ],
                      ),
                    ),
                    SliverFillRemaining(
                      hasScrollBody: false,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            DeliveryButton(
                                width: double.maxFinite,
                                label: 'FINALIZAR',
                                onPressed: () {
                                  var formValid =
                                      _formKey.currentState?.validate() ??
                                          false;
                                  if (paymentTypeId != null &&
                                      paymentSelected) {}
                                  if (formValid &&
                                      paymentTypeId != null &&
                                      paymentSelected) {
                                    print(paymentTypeId.toString());
                                  }
                                })
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
