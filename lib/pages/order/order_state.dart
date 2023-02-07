import 'package:equatable/equatable.dart';
import 'package:match/match.dart';

import '../../dto/order_product_dto.dart';
import '../../models/payment_type_model.dart';

part 'order_state.g.dart';

@match
enum OrderStatus {
  initial,
  loading,
  loaded,
  errorLoading,
  updateOrder,
  confirmRemoveProduct,
  emptyBag,
  success,
}

class OrderState extends Equatable {
  final String? errorMessage;
  final OrderStatus status;
  final List<OrderProductDto> orderProducts;
  final List<PaymentTypeModel> paymentTypes;

  const OrderState({
    this.errorMessage,
    required this.status,
    required this.orderProducts,
    required this.paymentTypes,
  });

  const OrderState.initial()
      : status = OrderStatus.initial,
        errorMessage = null,
        orderProducts = const [],
        paymentTypes = const [];

  double get totalOrder => orderProducts.fold<double>(
      0.0, (total, element) => total += element.totalPrice);

  @override
  List<Object> get props => [status, orderProducts, paymentTypes];

  OrderState copyWith({
    String? errorMessage,
    OrderStatus? status,
    List<OrderProductDto>? orderProducts,
    List<PaymentTypeModel>? paymentTypes,
  }) {
    return OrderState(
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      orderProducts: orderProducts ?? this.orderProducts,
      paymentTypes: paymentTypes ?? this.paymentTypes,
    );
  }
}

class OrderDeleteProductState extends OrderState {
  final OrderProductDto orderProduct;
  final int index;

  const OrderDeleteProductState({
    required this.orderProduct,
    required this.index,
    required super.errorMessage,
    required super.status,
    required super.orderProducts,
    required super.paymentTypes,
  });
}
