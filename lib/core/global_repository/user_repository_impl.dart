import 'package:dartz/dartz.dart';

import '../../exports.dart';

class UserRepositoryImpl implements UserRepository {
  final ApiService apiService;
  const UserRepositoryImpl(this.apiService);

  @override
  Future<Either<Exceptions, User>> getUser() async {
    try {
      final isValid = await apiService.post('/tokenIsValid');
      if (isValid == true) {
        final response = await apiService.get('/');
        final user = User.fromJson(response);
        return right(user);
      } else {
        return right(const User(
          address: '',
          email: '',
          id: '',
          name: '',
          password: '',
          token: '',
          type: '',
        ));
      }
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

   @override
  Future<Either<Exceptions, User>> addAddress(String address) async {
    try {
    final response=   await apiService.put('/api/address', body: {"address": address});
        final user = User.fromJson(response);

      return right(user);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }
}
