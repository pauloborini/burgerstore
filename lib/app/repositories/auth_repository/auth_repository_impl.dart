import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:burgerstore/app/core/exceptions/repository_exception.dart';
import 'package:burgerstore/app/core/exceptions/unauthorized_exception.dart';
import 'package:burgerstore/app/repositories/auth_repository/auth_repository.dart';

import '../../core/rest_client/custom_dio.dart';
import '../../models/auth_model.dart';

class AuthRepositoryImpl implements AuthRepository {
  final CustomDio dio;

  const AuthRepositoryImpl({required this.dio});

  @override
  Future<void> register(String name, String email, String password) async {
    try {
      await dio.unauth().post('/users', data: {
        'name': name,
        'email': email,
        'password': password,
      });
    } on DioError catch (e, s) {
      log('Erro ao registrar usuário', error: e, stackTrace: s);
      throw const RepositoryException(message: 'Erro ao registrar usuário');
    }
  }

  @override
  Future<AuthModel> login(String email, String password) async {
    try {
      final result = await dio.unauth().post('/auth', data: {
        'email': email,
        'password': password,
      });
      return AuthModel.fromMap(result.data);
    } on DioError catch (e, s) {
      if (e.response?.statusCode == 403) {
        log('Login ou senha inválidos', error: e, stackTrace: s);
        throw const UnauthorizedException(message: 'Login ou senha inválidos');
      }
      log('Erro ao realizar login', error: e, stackTrace: s);
      throw const RepositoryException(message: 'Erro ao realizar login');
    }
  }
}
