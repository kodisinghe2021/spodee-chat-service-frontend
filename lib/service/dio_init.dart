

import 'package:dio/dio.dart';
import 'package:ws_test_app/util/routes.dart';

class GetDio{
 static Dio getDio(){
    Dio dio = Dio();
    dio.options.baseUrl = BASE_URL;
    return dio;
  }
}