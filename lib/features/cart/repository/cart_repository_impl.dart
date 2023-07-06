import 'package:dartz/dartz.dart';

import '../../../exports.dart';

class CartRepositoryImpl implements CartRepository {
  final ApiService apiService;

  const CartRepositoryImpl(this.apiService);

  @override
  Future<Either<Exceptions, Unit>> addCartItem(String productId) async {
    try {
      await apiService.post('/api/cart/add', body: {"productId": productId});
      return right(unit);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exceptions, Unit>> removeCartItem(String productId) async {
    try {
      await apiService.delete('/api/cart/remove/$productId');
      return right(unit);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exceptions, Unit>> deleteCartItem(String productId) async {
    try {
      await apiService.delete('/api/cart/delete/$productId');
      return right(unit);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exceptions, Cart>> getCart() async {
    try {
      final response = await apiService.get('/api/cart/');
      final cart = Cart.fromJson(response);
      return right(cart);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exceptions, Unit>> createOrder(
      {required String cartId, required String address}) async {
    try {
      await apiService.post('/api/order/$cartId', body: {"address": address});
      return right(unit);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }
}
