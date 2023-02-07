import 'dart:developer';

import 'package:burgerstore/dto/order_dto.dart';
import 'package:burgerstore/dto/order_product_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/order_repository/order_repository.dart';
import 'order_state.dart';

class OrderController extends Cubit<OrderState> {
  final OrderRepository _orderRepository;

  OrderController(this._orderRepository) : super(const OrderState.initial());

  Future<void> loadProducts(List<OrderProductDto> products) async {
    try {
      emit(state.copyWith(status: OrderStatus.loading));
      final paymentsTypes = await _orderRepository.getAllPaymentsTypes();
      emit(state.copyWith(
          orderProducts: products,
          paymentTypes: paymentsTypes,
          status: OrderStatus.loaded));
    } catch (e, s) {
      log('Erro ao buscar métodos de pagamento', error: e, stackTrace: s);
      emit(state.copyWith(status: OrderStatus.errorLoading));
    }
  }

  incrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(
        state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  decrementProduct(int index) {
    final orders = [...state.orderProducts];
    final order = orders[index];
    final amount = order.amount;
    if (amount == 1) {
      if (state.status != OrderStatus.confirmRemoveProduct) {
        emit(OrderDeleteProductState(
            orderProduct: order,
            index: index,
            errorMessage: state.errorMessage,
            status: OrderStatus.confirmRemoveProduct,
            orderProducts: state.orderProducts,
            paymentTypes: state.paymentTypes));
        return;
      } else {
        orders.removeAt(index);
      }
    } else {
      orders[index] = order.copyWith(amount: order.amount - 1);
    }
    if (orders.isEmpty) {
      emit(state.copyWith(status: OrderStatus.emptyBag));
      return;
    }
    emit(
        state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }

  cancelDeleteProcess() {
    emit(state.copyWith(status: OrderStatus.loaded));
  }

  emptyBag() {
    emit(state.copyWith(status: OrderStatus.emptyBag));
  }

  clearBag() {
    emit(state.copyWith(
        orderProducts: <OrderProductDto>[], status: OrderStatus.initial));
  }

  Future<void> saveOrder(
      {required List<OrderProductDto> products,
      required String address,
      required String document,
      required int paymentMethodId}) async {
    emit(state.copyWith(status: OrderStatus.loading));
    await _orderRepository.saveOrder(OrderDto(
        products: products,
        address: address,
        document: document,
        paymentMethodId: paymentMethodId));
    emit(state.copyWith(status: OrderStatus.success));
  }
}
