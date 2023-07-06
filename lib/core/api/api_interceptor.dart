import '../../exports.dart';

class AppInterceptors extends Interceptor {
  const AppInterceptors();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    debugPrint('REQUEST[${options.method}] => PATH: ${options.path}');
    final pref = sl<SharedPreferences>();
    final token = pref.getString(cacheToken);
    if (token == null) {
      pref.setString(cacheToken, '');
    }
    options.headers = {
      "Content-type": "application/json",
      "x-auth-token": token
    };
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    debugPrint(
        'RESPONSE[${response.statusCode}] => PATH: ${response.requestOptions.path}');

    super.onResponse(response, handler);
  }

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) {
    debugPrint(
        'ERROR[${err.response?.statusCode}] => PATH: ${err.requestOptions.path}');
    super.onError(err, handler);
  }
}
