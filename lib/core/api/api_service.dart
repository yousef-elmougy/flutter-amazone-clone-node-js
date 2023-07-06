abstract class ApiService {
  const ApiService();
  Future get(
    String path, {
    Map<String, dynamic>? queryParameters,
  });
  Future post(
    String path, {
    Map<String, dynamic>? queryParameters,
    Object? body,
   });
  Future put(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  });
  Future delete(
    String path, {
    Map<String, dynamic>? queryParameters,
    Map<String, dynamic>? body,
  });
}
