import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../dto/order_product_dto.dart';

part 'order_state.g.dart';

@match
enum OrderStatus { initial, loading, loaded, errorLoading }

class OrderState extends Equatable {
  final OrderStatus status;
  final String? errorMessage;
  final List<OrderProductDto> orderProduct;

  const OrderState({
    required this.status,
    this.errorMessage,
    required this.orderProduct,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        orderProduct = const [],
        errorMessage = null;

  @override
  List<Object> get props => [status, orderProduct];

  OrderState copyWith({
    OrderStatus? status,
    String? errorMessage,
    List<OrderProductDto>? orderProduct,
  }) {
    return OrderState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
      orderProduct: orderProduct ?? this.orderProduct,
    );
  }
}
