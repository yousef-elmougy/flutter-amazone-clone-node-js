import 'package:dartz/dartz.dart';

import '../../exports.dart';

abstract class UserRepository {
const  UserRepository();
  Future<Either<Exceptions, User>> getUser();
  Future<Either<Exceptions, User>> addAddress(String address);
}
