part of 'product_detail_controller.dart';

abstract class ProductDetailState extends Equatable {
  const ProductDetailState();
}

class ProductDetailInitial extends ProductDetailState {
  @override
  List<Object> get props => [];
}
