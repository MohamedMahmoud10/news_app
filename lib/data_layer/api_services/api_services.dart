import 'package:dio/dio.dart';

class ApiServices {
  late Dio dio;
  ApiServices() {
    BaseOptions baseOptions = BaseOptions(
      receiveDataWhenStatusError: true,
      receiveTimeout: 2 * 1000,
      connectTimeout: 2 * 1000,
      baseUrl: 'https://newsapi.org/',
    );
    dio = Dio(baseOptions);
    dio.interceptors.add(LogInterceptor(
      request: true,
      requestHeader: true,
      requestBody: true,
      responseHeader: true,
      responseBody: true,
      error: true,
      logPrint: print,
    ));
  }
  Future<List<dynamic>> getNewsData(
      String url, Map<String, dynamic> query) async {
    final res = await dio.get(url, queryParameters: query);
    var data = res.data['articles'];
    return data;
  }
}
