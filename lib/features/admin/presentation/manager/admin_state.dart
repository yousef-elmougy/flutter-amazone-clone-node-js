part of 'admin_cubit.dart';

@immutable
abstract class AdminState {
  const AdminState();
}

class ProductControlInitial extends AdminState {
  const ProductControlInitial();
}

/// SELECT IMAGE
class SelectProductImagesLoading extends AdminState {}

class SelectProductImagesSuccess extends AdminState {}

/// CREATE product
class AddProductLoading extends AdminState {
  const AddProductLoading();
}

class AddProductSuccess extends AdminState {
  const AddProductSuccess();
}

class AddProductError extends AdminState {
  final String error;
  const AddProductError(this.error);
}

/// DELETE product
class DeleteProductLoading extends AdminState {
  const DeleteProductLoading();
}

class DeleteProductSuccess extends AdminState {
  const DeleteProductSuccess();
}

class DeleteProductError extends AdminState {
  final String error;
  const DeleteProductError(this.error);
}

/// GET all Products
class GetAllProductsLoading extends AdminState {
  const GetAllProductsLoading();
}

class GetAllProductsSuccess extends AdminState {}

class GetAllProductsError extends AdminState {
  final String error;
  const GetAllProductsError(this.error);
}

/// GET all Orders
class GetAllOrdersLoading extends AdminState {
  const GetAllOrdersLoading();
}

class GetAllOrdersSuccess extends AdminState {}

class GetAllOrdersError extends AdminState {
  final String error;
  const GetAllOrdersError(this.error);
}

/// GET all Orders
class GetAnalyticsLoading extends AdminState {
  const GetAnalyticsLoading();
}

class GetAnalyticsSuccess extends AdminState {}

class GetAnalyticsError extends AdminState {
  final String error;
  const GetAnalyticsError(this.error);
}
