import 'package:dartz/dartz.dart';

import '../../../exports.dart';

abstract class AccountRepository {
  const AccountRepository();

  Future<Either<Exceptions, List<Orders>>> getUserOrders();
  Future<Either<Exceptions, Unit>> changeOrderStatus({
    required String orderId,
    required int status,
  });
}
