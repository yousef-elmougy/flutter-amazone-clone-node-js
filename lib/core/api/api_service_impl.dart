import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:flutter/foundation.dart';

import 'api_interceptor.dart';
import 'api_service.dart';

class ApiServiceImpl implements ApiService {
  final Dio client;

  ApiServiceImpl(this.client) {
    client.httpClientAdapter = IOHttpClientAdapter()
      ..onHttpClientCreate = (client) =>
          client..badCertificateCallback = (cert, host, port) => true;

    client.options = BaseOptions(
      baseUrl: '',
      connectTimeout: const Duration(seconds: 20),
      receiveTimeout: const Duration(seconds: 20),
      receiveDataWhenStatusError: true,
      responseType: ResponseType.plain,
      followRedirects: false,
    );

    if (kDebugMode) {
      client.interceptors.add(const AppInterceptors());
      client.interceptors.add(
        LogInterceptor(
          requestBody: true,
          responseBody: true,
          logPrint: (object) => debugPrint(object.toString()),
        ),
      );
    }
  }

  @override
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.get(
      path,
      queryParameters: queryParameters,
    );
    debugPrint("response ------------------------->> $response");
    return jsonDecode(response.data);
  }

  @override
  Future post(
    String path, {
    Object? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response = await client.post(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return jsonDecode(response.data);
  }

  @override
  Future put(
    String path, {
    Map<String, dynamic>? body,
    Map<String, dynamic>? queryParameters,
  }) async {
    final response =
        await client.put(path, queryParameters: queryParameters, data: body);
    return jsonDecode(response.data);
  }

  @override
  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  }) async {
    final response = await client.delete(
      path,
      queryParameters: queryParameters,
      data: body,
    );
    return jsonDecode(response.data);
  }
}
