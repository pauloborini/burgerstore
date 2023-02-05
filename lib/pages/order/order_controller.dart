import 'package:burgerstore/dto/order_product_dto.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../repositories/order_repository/order_repository.dart';
import 'order_state.dart';

class OrderController extends Cubit<OrderState> {

  final OrderRepository _orderRepository;

  OrderController(this._orderRepository) : super(const OrderState.initial());

  void loadProducts(List<OrderProductDto> products) {
    emit(state.copyWith(orderProduct: products));
  }
}
