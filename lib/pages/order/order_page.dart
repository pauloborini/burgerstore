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
  final _addressEC = TextEditingController();
  final _documentEC = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  int? paymentTypeId;
  bool paymentSelected = false;

  @override
  void dispose() {
    _addressEC.dispose();
    _documentEC.dispose();
    super.dispose();
  }

  @override
  onReady() {
    final products =
        ModalRoute.of(context)!.settings.arguments as List<OrderProductDto>;
    controller.loadProducts(products);
  }

  _showDialogRemoveItem(OrderDeleteProductState state) {
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
                    controller.cancelDeleteProcess();
                  },
                  child: Text(
                    'Não',
                    style: context.textStyles.medium
                        .copyWith(fontSize: 19, color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                    controller.decrementProduct(state.index);
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

  _showDialogClearBag() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text('Deseja limpar o carrinho?'),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                      overlayColor: MaterialStatePropertyAll(
                          Colors.red.withOpacity(0.1))),
                  child: Text(
                    'Não',
                    style: context.textStyles.medium
                        .copyWith(fontSize: 19, color: Colors.black),
                  )),
              TextButton(
                  onPressed: () {
                    controller.clearBag();
                    Navigator.of(context).pop(true);
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
  Widget build(BuildContext context) {
    return BlocListener<OrderController, OrderState>(
      listener: (context, state) {
        state.status.matchAny(
            any: () => hideLoader(),
            loading: () => showLoader(),
            loaded: () => hideLoader(),
            initial: () {
              showInfo('Adicione um item ao carrinho');
              Navigator.of(context).pop(<OrderProductDto>[]);
            },
            errorLoading: () {
              hideLoader();
              showError(state.errorMessage ?? 'Erro ao carregar página');
            },
            confirmRemoveProduct: () {
              hideLoader();
              if (state is OrderDeleteProductState) {
                _showDialogRemoveItem(state);
              }
            },
            emptyBag: () {
              showInfo('Adicione um item ao carrinho');
              Navigator.of(context).pop(<OrderProductDto>[]);
            },
            success: () {
              hideLoader();
              showSuccess('Pedido realizado com sucesso');
              Navigator.pushReplacementNamed(context, '/order/completed',
                  result: <OrderProductDto>[]);
            });
      },
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onPanDown: (_) {
          FocusScope.of(context).requestFocus(FocusNode());
        },
        child: Scaffold(
          appBar: BaseAppBar(
            appBar: AppBar(),
            leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop(controller.state.orderProducts);
              },
              icon: const Icon(Icons.arrow_back_ios_new),
            ),
          ),
          body: Container(
            constraints: const BoxConstraints(maxWidth: 1440),
            padding: const EdgeInsets.only(left: 15, right: 15, top: 10),
            child: BlocSelector<OrderController, OrderState,
                List<OrderProductDto>>(
              selector: (state) {
                return state.orderProducts;
              },
              builder: (context, orderProducts) {
                return Form(
                  key: _formKey,
                  child: CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: Row(
                          children: [
                            Text(
                              'Carrinho',
                              style: context.textStyles.xBold
                                  .copyWith(fontSize: 28),
                            ),
                            IconButton(
                                onPressed: () => _showDialogClearBag(),
                                icon: const Icon(
                                  Icons.delete_outline,
                                  color: Colors.red,
                                ))
                          ],
                        ),
                      ),
                      SliverList(
                        delegate: SliverChildBuilderDelegate(
                            childCount: orderProducts.length, (context, index) {
                          return Column(
                            children: [
                              const SizedBox(height: 10),
                              OrderProductItem(
                                index: index,
                                orderProduct: orderProducts.elementAt(index),
                              )
                            ],
                          );
                        }),
                      ),
                      SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text('Total do pedido',
                                      style: context.textStyles.bold
                                          .copyWith(fontSize: 16)),
                                  BlocSelector<OrderController, OrderState,
                                      double>(
                                    selector: (state) => state.totalOrder,
                                    builder: (context, totalOrder) {
                                      return Text(totalOrder.currencyPtBR,
                                          style: context.textStyles.xBold
                                              .copyWith(
                                                  fontSize: 20,
                                                  color: context
                                                      .colors.secondary));
                                    },
                                  ),
                                ]),
                            const Divider(
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            OrderField(
                              title: 'Endereço de Entrega',
                              controller: _addressEC,
                              validator: Validatorless.required(
                                  'Endereço Obrigatório'),
                              hintText: 'Digite o endereço',
                              keyboardType: TextInputType.text,
                            ),
                            const SizedBox(height: 10),
                            OrderField(
                              title: 'CPF',
                              controller: _documentEC,
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
                                      setState(() {
                                        paymentTypeId = value;
                                        paymentSelected = true;
                                      });
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
                                    if (formValid &&
                                        paymentTypeId != null &&
                                        paymentSelected) {
                                      controller.saveOrder(
                                          products: orderProducts,
                                          address: _addressEC.text,
                                          document: _documentEC.text.toString(),
                                          paymentMethodId: paymentTypeId!);
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
      ),
    );
  }
}
