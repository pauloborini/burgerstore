import 'dart:developer';

import 'package:burgerstore/core/exceptions/unauthorized_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../repositories/auth_repository/auth_repository.dart';
import 'login_state.dart';

class LoginController extends Cubit<LoginState> {
  final AuthRepository authRepository;

  LoginController({required this.authRepository}) : super(const LoginState.initial());

  Future<void> login(String email, String password) async {
    try {
      emit(state.copyWith(status: LoginStatus.login));
      final authModel = await authRepository.login(email, password);
      final sp = await SharedPreferences.getInstance();
      sp.setString('access_token', authModel.accessToken);
      sp.setString('refresh_token', authModel.refreshToken);
      emit(state.copyWith(status: LoginStatus.success));
    } on UnauthorizedException catch (e, s) {
      log('Login ou senha inválidos', error: e, stackTrace: s);
      emit(state.copyWith(status: LoginStatus.error, errorMessage: 'Login ou senha inválidos'));
    } catch (e, s) {
      log('Erro ao realizar login', error: e, stackTrace: s);
      emit(state.copyWith(status: LoginStatus.error, errorMessage: 'Erro ao realizar login'));
    }
  }
}
