part of 'cart_cubit.dart';

@immutable
abstract class CartState {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
}

/// Add Item To Cart
class AddCartLoading extends CartState {
  const AddCartLoading();
}

class AddCartSuccess extends CartState {
  const AddCartSuccess();
}

class AddCartError extends CartState {
  final String error;
  const AddCartError(this.error);
}

/// Get Cart
class GetCartLoading extends CartState {
  const GetCartLoading();
}

class GetCartSuccess extends CartState {}

class GetCartError extends CartState {
  final String error;
  const GetCartError(this.error);
}

/// Remove Item From Cart
class RemoveCartLoading extends CartState {
  const RemoveCartLoading();
}

class RemoveCartSuccess extends CartState {
  const RemoveCartSuccess();
}

class RemoveCartError extends CartState {
  final String error;
  const RemoveCartError(this.error);
}

/// Delete Item From Cart
class DeleteCartLoading extends CartState {
  const DeleteCartLoading();
}

class DeleteCartSuccess extends CartState {
  const DeleteCartSuccess();
}

class DeleteCartError extends CartState {
  final String error;
  const DeleteCartError(this.error);
}

/// CREATE Order
class CreateOrderLoading extends CartState {
  const CreateOrderLoading();
}

class CreateOrderSuccess extends CartState {
  const CreateOrderSuccess();
}

class CreateOrderError extends CartState {
  final String error;
  const CreateOrderError(this.error);
}
