import 'package:dio/dio.dart';

class DioHelper {
  static Dio? dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://dummyjson.com/',
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response?> getData(
      {
        required String url,
        Map<String, dynamic>? query,
        String lang = 'en',
        String? token,
      }) async{
    dio?.options.headers =
      {
        'lang':lang,
      };
   return await dio?.get(
      url,
      queryParameters: query,
    );
  }



}

