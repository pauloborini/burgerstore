import '../models/product_model.dart';

class OrderProductDto {
  final ProductModel product;
  final int amount;

  const OrderProductDto({
    required this.product,
    required this.amount,
  });

  double get totalPrice => amount * product.price;

  OrderProductDto copyWith({
    ProductModel? product,
    int? amount,
  }) {
    return OrderProductDto(
      product: product ?? this.product,
      amount: amount ?? this.amount,
    );
  }
}
