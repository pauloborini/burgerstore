import 'dart:developer';

import 'package:burgerstore/core/exceptions/repository_exception.dart';
import 'package:burgerstore/dto/order_dto.dart';
import 'package:dio/dio.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../models/payment_type_model.dart';
import 'order_repository.dart';

class OrderRepositoryImpl implements OrderRepository {
  final CustomDio dio;

  const OrderRepositoryImpl({
    required this.dio,
  });

  @override
  Future<List<PaymentTypeModel>> getAllPaymentsTypes() async {
    try {
      final result = await dio.auth().get('/payment-types');
      return result.data
          .map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p))
          .toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw const RepositoryException(
          message: 'Erro ao buscar formas de pagamento');
    }
  }

  @override
  Future<void> saveOrder(OrderDto orderDto) async {
    try {
      await dio.auth().post('/orders', data: {
        'produts': orderDto.products
            .map((p) => {
                  'id': p.product.id,
                  'amount': p.amount,
                  'total_price': p.totalPrice
                })
            .toList(),
        'user_id': '#userAuthRef',
        'address': orderDto.address,
        'CPF': orderDto.document,
        'payment_method_id': orderDto.paymentMethodId
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar pedido', error: e, stackTrace: s);
      throw const RepositoryException(message: 'Erro ao registrar pedido');
    }
  }
}
