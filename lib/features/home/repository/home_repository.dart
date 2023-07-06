import 'package:dartz/dartz.dart';

import '../../../exports.dart';

abstract class HomeRepository {
  const HomeRepository();

  Future<Either<Exceptions, List<Product>>> getProductsByCategory(
    String category,
  );
  Future<Either<Exceptions, Product>> getProduct(
    String productId,
  );
  Future<Either<Exceptions, List<Product>>> search(String query);

  Future<Either<Exceptions, List<Product>>> getDealOfTheDay();

  Future<Either<Exceptions, Unit>> addRating({
    required String productId,
    required double rating,
  });
}
