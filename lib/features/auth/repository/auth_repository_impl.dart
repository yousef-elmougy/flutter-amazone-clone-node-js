import 'package:dartz/dartz.dart';

import '../../../exports.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;

  const AuthRepositoryImpl(this.apiService);

  @override
  Future<Either<Exceptions, Unit>> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      await apiService.post('/api/register', body: {
        "name": name,
        "email": email,
        "password": password,
      });
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
  Future<Either<Exceptions, Map<String, dynamic>>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await apiService.post('/api/login', body: {
        "email": email,
        "password": password,
      });
      return right(response);
    } catch (e) {
      if (e is DioError) {
        return left(ServerException.getDioException(e));
      } else {
        return left(ServerException(e.toString()));
      }
    }
  }

  
}
