import 'package:dio/dio.dart';

import '../shared_preference/shared_preference.dart';
import 'apis.dart';

class DioHelper {
  static Dio dio = Dio();

  static init() {
    dio = Dio(
      BaseOptions(
          baseUrl: AppApis.baseUrl,
          receiveDataWhenStatusError: true,
          headers: {'Content-Type': 'application/json'}),);
  }


  static Future<Response<dynamic>> postData({required String url,FormData? dataOption,  Map<String, dynamic>? data, Map<String, dynamic>? query,String? token,String? language}) async
  {
    dio.options.headers = <String,dynamic >{'Accept-Language': language??'en','x-api-key':'SIv5q09xLI689LNoALEh2D4Af/TsFkoypEMd/2XdtvGPfKHmU6HENZuuBgaBQKXM',
      'Authorization':
      'Bearer $token'
    };
    return dio.post(url, data: data??dataOption, queryParameters: query);
  }


  static Future<Response> putData({required String url, required Map<String, dynamic> data, Map<String, dynamic>? query,}) async
  {
    var token  =  await CacheHelper.getDate(key: 'token');
    var lang  =  await CacheHelper.getDate(key: 'lang');
    dio.options.headers = {'lang': lang, 'Authorization': token};
    return dio.put(url, data: data, queryParameters: query);
  }



  static Future<dynamic> getData({required String url, Map<String, dynamic>? query,String?token, String? language}) async
  {
    dio.options.headers = <String, dynamic>{
      'Accept-Language': language??'en','x-api-key':'SIv5q09xLI689LNoALEh2D4Af/TsFkoypEMd/2XdtvGPfKHmU6HENZuuBgaBQKXM',
      'Authorization':
      'Bearer $token'};
    return dio.get(url, queryParameters: query);
  }


}
