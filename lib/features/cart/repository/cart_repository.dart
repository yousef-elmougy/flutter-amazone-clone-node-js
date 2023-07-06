import 'package:dartz/dartz.dart';

import '../../../exports.dart';

abstract class CartRepository {
  const CartRepository();
  Future<Either<Exceptions, Unit>> addCartItem(String productId);
  Future<Either<Exceptions, Unit>> removeCartItem(String productId);
  Future<Either<Exceptions, Unit>> deleteCartItem(String productId);
  Future<Either<Exceptions, Cart>> getCart();
  Future<Either<Exceptions, Unit>> createOrder({
    required String cartId,
    required String address,
  });
}
