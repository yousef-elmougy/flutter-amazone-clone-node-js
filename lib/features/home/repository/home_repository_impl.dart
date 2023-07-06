import 'package:dartz/dartz.dart';

import '../../../exports.dart';

class HomeRepositoryImpl implements HomeRepository {
  const HomeRepositoryImpl(this.apiService);
  final ApiService apiService;

  @override
  Future<Either<Exceptions, List<Product>>> getProductsByCategory(
    String category,
  ) async {
    try {
      final response =
          await apiService.get('/api/products?category=$category') as List;
      final products =
          response.map((product) => Product.fromJson(product)).toList();
      return right(products);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exceptions, List<Product>>> search(String query) async {
    try {
      final response = await apiService.get('/api/search?query=$query') as List;
      final products =
          response.map((product) => Product.fromJson(product)).toList();
      return right(products);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exceptions, Unit>> addRating({
    required String productId,
    required double rating,
  }) async {
    try {
      await apiService
          .post('/api/product/$productId/rating', body: {"rating": rating});
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
  Future<Either<Exceptions, Product>> getProduct(String productId) async {
    try {
      final response = await apiService.get('/api/product/$productId');
      final products = Product.fromJson(response);
      return right(products);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exceptions, List<Product>>> getDealOfTheDay() async {
    try {
      final response =
          await apiService.get('/api/products/sorted-by-rating') as List;
      final products =
          response.map((product) => Product.fromJson(product)).toList();
      return right(products);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }
}
