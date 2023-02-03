import 'package:bloc/bloc.dart';

class ProductDetailController extends Cubit<int> {
  late final bool _hasOrder;

  ProductDetailController() : super(1);

  initial(int amount, bool hasOrder) {
    _hasOrder = hasOrder;
    emit(amount);
  }

  increment() => emit(state + 1);

  decrement() {
    if (state > (_hasOrder ? 0 : 1)) {
      emit(state - 1);
    }
  }
}
