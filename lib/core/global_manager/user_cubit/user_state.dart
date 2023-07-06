part of 'user_cubit.dart';

@immutable
abstract class UserState {}

class UserInitial extends UserState {}

class SetUser extends UserState {
  SetUser();
}

class GetUserLoading extends UserState {
  GetUserLoading();
}

class GetUserSuccess extends UserState {
  final User user;
  GetUserSuccess(this.user);
}

class GetUserError extends UserState {
  final String error;
  GetUserError(this.error);
}

class AddAddressLoading extends UserState {
  AddAddressLoading();
}

class AddAddressSuccess extends UserState {
  final User user;
  AddAddressSuccess(this.user);
}

class AddAddressError extends UserState {
  final String error;
  AddAddressError(this.error);
}
