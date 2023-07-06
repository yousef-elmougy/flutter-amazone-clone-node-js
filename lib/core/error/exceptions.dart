import 'dart:convert';

import 'package:dio/dio.dart';

class Exceptions implements Exception {
  final String message;

  const Exceptions(this.message);

  @override
  String toString() => message;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Exceptions && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;
}

class ServerException extends Exceptions {
  const ServerException(super.message);

  factory ServerException.getDioException(DioError error) {
    switch (error.type) {
      case DioErrorType.connectionTimeout:
        return const ServerException('Connection Time Out');

      case DioErrorType.sendTimeout:
        return const ServerException('Send Time Out');

      case DioErrorType.receiveTimeout:
        return const ServerException('Receive Time Out');

      case DioErrorType.cancel:
        return const ServerException('Canceled');

      case DioErrorType.connectionError:
        return const ServerException('Connection Error Check the Internet');

      case DioErrorType.unknown:
        return const ServerException('Connection Error Check the Internet');

      case DioErrorType.badCertificate:
        return const ServerException('Invalidate Certificate');

      case DioErrorType.badResponse:
        return ServerException._handleResponseException(error.response!);
      default:
        return const UnExpectedException();
    }
  }

  factory ServerException._handleResponseException(Response response) {
      final jsonDecoded = json.decode(response.data);
      final message = jsonDecoded['message'];
      final error = jsonDecoded['error'];
      switch (response.statusCode) {
        case 400:
          return ServerException('$message');

        case 403:
        case 401:
          return const ServerException('Un authorized');

        case 404:
          return ServerException('Not Found Error 404 : $message');

        case 409:
          return const ServerException('Conflict Error');

        case 502:
          return const ServerException('Bad getWay');

        case 500:
          return ServerException('$error');
      }
      return const UnExpectedException();
    }
  
}

class UnExpectedException extends ServerException {
  const UnExpectedException(
      [super.message = 'Oops Something Went Wrong, please try again']);
}

class CacheException extends Exceptions {
  const CacheException(super.message);
}
