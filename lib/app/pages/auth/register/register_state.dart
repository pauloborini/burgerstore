part of 'register_cubit.dart';

abstract class RegisterState {}

@match
enum RegisterStatus { initial, register, success, error }

class RegisterInitial extends RegisterState {}
