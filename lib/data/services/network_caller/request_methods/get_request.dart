import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mini_ecom/data/services/network_caller/network_response.dart';
import 'package:mini_ecom/data/utils/token_keeper.dart';

class GetRequest {
  static Dio dio = Dio();

  static Future<NetworkResponse> execute(String url) async {
    try {
      Response response = await dio.get(url,
          options: Options(
            headers: {'token': TokenKeeper.accessToken.toString()},
          ));

      if (response.statusCode == 200 || response.statusCode == 201) {
        return NetworkResponse(true, response.statusCode!, response.data);
      } else {
        log(response.statusCode.toString());
        return NetworkResponse(false, response.statusCode!, null);
      }
    } catch (e) {
      //  dio errors handle
      if (e is DioException && e.response?.statusCode == 401) {
        // log(e.response!.statusCode.toString());
        // TokenKeeper.clear();
        return NetworkResponse(false, e.response!.statusCode!, null);
      } else if (e is DioException && e.error is SocketException) {
        log(e.error.toString());
        return NetworkResponse(false, 7, null);
      } else {
        log(e.toString());
        return NetworkResponse(false, -1, null);
      }
    }
  }
}
