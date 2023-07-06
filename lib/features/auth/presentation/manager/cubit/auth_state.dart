part of 'auth_cubit.dart';

abstract class AuthState {
  const AuthState();
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthToggle extends AuthState {}

class RegisterLoading extends AuthState {
  const RegisterLoading();
}

class RegisterSuccess extends AuthState {
  const RegisterSuccess();
}

class RegisterError extends AuthState {
  final String error;
  const RegisterError(this.error);
}

class LoginLoading extends AuthState {
  const LoginLoading();
}

class LoginSuccess extends AuthState {
  final Map<String,dynamic> response;
  const LoginSuccess(this.response);
}

class LoginError extends AuthState {
  final String error;
  const LoginError(this.error);
}

