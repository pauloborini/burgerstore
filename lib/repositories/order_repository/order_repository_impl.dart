import 'dart:developer';

import 'package:burgerstore/core/exceptions/repository_exception.dart';
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
      return result.data.map<PaymentTypeModel>((p) => PaymentTypeModel.fromMap(p)).toList();
    } on DioError catch (e, s) {
      log('Erro ao buscar formas de pagamento', error: e, stackTrace: s);
      throw const RepositoryException(message: 'Erro ao buscar formas de pagamento');
    }
  }
}
