import 'package:dartz/dartz.dart';

import '../../../exports.dart';

class AccountRepositoryImpl implements AccountRepository {
  final ApiService apiService;

  const AccountRepositoryImpl(this.apiService);

  @override
  Future<Either<Exceptions, List<Orders>>> getUserOrders() async {
    try {
      final response = await apiService.get('/api/orders/') as List;
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
  Future<Either<Exceptions, Unit>> changeOrderStatus({
    required String orderId,
    required int status,
  }) async {
    try {
      await apiService
          .put('/admin/order-status/$orderId', body: {"status": status});
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
