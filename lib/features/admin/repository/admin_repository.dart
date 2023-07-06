import 'package:dartz/dartz.dart';

import '../../../exports.dart';

abstract class AdminRepository {
  const AdminRepository();
  Future<Either<Exceptions, Unit>> addProduct({
    required String name,
    required String description,
    required List<String> images,
    required String category,
    required double price,
    required double quantity,
  });

  Future<Either<Exceptions, Unit>> deleteProduct(String id);
  Future<Either<Exceptions, List<Product>>> getAllProducts();
  Future<Either<Exceptions, List<Orders>>> getAllOrders();
  Future<Either<Exceptions, Analytics>> getAnalytics();
}
