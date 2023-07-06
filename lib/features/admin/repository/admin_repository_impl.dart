import 'package:dartz/dartz.dart';

import '../../../exports.dart';

class AdminRepositoryImpl implements AdminRepository {
  final ApiService apiService;
  const AdminRepositoryImpl(this.apiService);

  @override
  Future<Either<Exceptions, Unit>> addProduct({
    required String name,
    required String description,
    required List<String> images,
    required String category,
    required double price,
    required double quantity,
  }) async {
    try {
      final cloudinary = CloudinaryPublic('dvadtkayd', 'dv8wswlf');
      List<String> imageUrls = [];

      for (int i = 0; i < images.length; i++) {
        CloudinaryResponse res = await cloudinary.uploadFile(
          CloudinaryFile.fromFile(images[i],
              folder: 'Products', resourceType: CloudinaryResourceType.Image),
        );
        imageUrls.add(res.secureUrl);
      }

      if (images.isEmpty) {
        return left(const ServerException('image is required'));
      }

      final product = Product(
        name: name,
        description: description,
        price: price,
        quantity: quantity,
        category: category,
        images: imageUrls,
        ratings: [],
        averageRating: 0,
      );
      await apiService.post('/admin/product', body: product.toJson());
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
  Future<Either<Exceptions, List<Product>>> getAllProducts() async {
    try {
      final response = await apiService.get('/admin/products') as List;
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
  Future<Either<Exceptions, Unit>> deleteProduct(String id) async {
    try {
      await apiService.delete('/admin/product/$id');
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
  Future<Either<Exceptions, List<Orders>>> getAllOrders() async {
    try {
      final response = await apiService.get('/admin/orders/') as List;
      final orders = response.map((order) => Orders.fromJson(order)).toList();
      return right(orders);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  @override
  Future<Either<Exceptions, Analytics>> getAnalytics() async {
    try {
      final response = await apiService.get('/admin/analytics/');
      final analytics = Analytics.fromJson(response);
      return right(analytics);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }
}
