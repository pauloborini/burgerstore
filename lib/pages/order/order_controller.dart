import 'dart:developer';

import 'package:burgerstore/dto/order_product_dto.dart';
import 'package:dio/dio.dart';
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
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 401) {
        log('Conexão Expirou, efetue novamente o Login',
            error: e, stackTrace: s);
        emit(state.copyWith(status: OrderStatus.error401));
      }
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
    if(amount == 1 ){

    }
    orders[index] = order.copyWith(amount: order.amount + 1);
    emit(
        state.copyWith(orderProducts: orders, status: OrderStatus.updateOrder));
  }
}
