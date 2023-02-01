import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'product_detail_state.dart';

class ProductDetailController extends Cubit<int> {
  ProductDetailController() : super(1);

  increment() => emit(state + 1);

  decrement() => emit(state > 1 ? state - 1 : state);
}
