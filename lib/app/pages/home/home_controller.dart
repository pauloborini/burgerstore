import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:vakinhaburger/app/dto/order_product_dto.dart';

import '../../repositories/products_repository/products_repository.dart';
import 'home_state.dart';

class HomeController extends Cubit<HomeState> {
  final ProductsRepository _productsRepository;

  HomeController(this._productsRepository) : super(const HomeState.initial());

  Future<void> loadProducts() async {
    emit(state.copyWith(status: HomeStateStatus.loading));
    try {
      final products = await _productsRepository.findAllProducts();
      emit(state.copyWith(status: HomeStateStatus.loaded, products: products));
    } on Exception catch (e, s) {
      log('Erro ao buscar produtos', error: e, stackTrace: s);
      emit(state.copyWith(
          status: HomeStateStatus.error, errorMessage: 'Erro ao buscar produtos'));
    }
  }

  void addOrUpdateBag(OrderProductDto orderProduct) {
    final shoppingBag = [...state.shoppingBag];
    shoppingBag.add(orderProduct);
    emit(state.copyWith(shoppingBag: shoppingBag));
  }
}
