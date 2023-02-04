import 'package:equatable/equatable.dart';

enum LoginStatus { initial, login, success, loginError, error }

class LoginState extends Equatable {
  final LoginStatus status;
  final String? errorMessage;

  const LoginState({
    required this.status,
    this.errorMessage,
  });

  @override
  List<Object?> get props => throw UnimplementedError();
}
