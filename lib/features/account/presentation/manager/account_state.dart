part of 'account_cubit.dart';

@immutable
abstract class AccountState {
  const AccountState();
}

class AccountInitial extends AccountState {
  const AccountInitial();
}

///
class GetUserOrdersLoading extends AccountState {
  const GetUserOrdersLoading();
}

class GetUserOrdersSuccess extends AccountState {}

class GetUserOrdersError extends AccountState {
  final String error;
  const GetUserOrdersError(this.error);
}

///
class ChangeOrderStatusLoading extends AccountState {
  const ChangeOrderStatusLoading();
}

class ChangeOrderStatusSuccess extends AccountState {
  const ChangeOrderStatusSuccess();
}

class ChangeOrderStatusError extends AccountState {
  final String error;
  const ChangeOrderStatusError(this.error);
}
