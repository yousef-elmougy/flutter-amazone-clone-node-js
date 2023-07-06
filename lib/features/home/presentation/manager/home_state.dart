part of 'home_cubit.dart';

@immutable
abstract class HomeState {
  const HomeState();
}

class HomeInitial extends HomeState {
  const HomeInitial();
}

/// GET products by category
class GetProductsByCategoryLoading extends HomeState {
  const GetProductsByCategoryLoading();
}

class GetProductsByCategorySuccess extends HomeState {}

class GetProductsByCategoryError extends HomeState {
  final String error;
  const GetProductsByCategoryError(this.error);
}

/// SEARCH
class SearchLoading extends HomeState {
  const SearchLoading();
}

class SearchSuccess extends HomeState {}

class SearchError extends HomeState {
  final String error;
  const SearchError(this.error);
}

/// ADD RATING
class AddRatingLoading extends HomeState {
  const AddRatingLoading();
}

class AddRatingSuccess extends HomeState {
  const AddRatingSuccess();
}

class AddRatingError extends HomeState {
  final String error;
  const AddRatingError(this.error);
}

/// GET rating product
class GetProductLoading extends HomeState {
  const GetProductLoading();
}

class GetProductSuccess extends HomeState {}

class GetProductError extends HomeState {
  final String error;
  const GetProductError(this.error);
}

/// GET products by category
class DealOfTheDayLoading extends HomeState {
  const DealOfTheDayLoading();
}

class DealOfTheDaySuccess extends HomeState {}

class DealOfTheDayError extends HomeState {
  final String error;
  const DealOfTheDayError(this.error);
}
