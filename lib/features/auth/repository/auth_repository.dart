import 'package:dartz/dartz.dart';

import '../../../exports.dart';

abstract class AuthRepository {
  const AuthRepository();
  Future<Either<Exceptions, Unit>> register({
    required String name,
    required String email,
    required String password,
  });
  Future<Either<Exceptions, Map<String, dynamic>>> login({
    required String email,
    required String password,
  });

}
