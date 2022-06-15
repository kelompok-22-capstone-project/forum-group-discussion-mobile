import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moot/models/error_Respond.dart';
import 'package:moot/models/login.dart';
import 'package:moot/models/register.dart';

class ApiService {
  final Dio _dio = Dio();

  final String _baseUrl = 'https://moot-rest-api.herokuapp.com/api/v1';

  Future<Login?> postLogin(String username, String password) async {
    Login? user;

    try {
      var response = await _dio.post("$_baseUrl/login",
          options: Options(headers: {"API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j"}),
          data: {"username": username, "password": password});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        user = Login.fromJson(data);
      }
    } on DioError catch (e) {
      if (e.response != null) {
        debugPrint('Dio error!');
        debugPrint('STATUS: ${e.response?.statusCode}');
        debugPrint('DATA: ${e.response?.data}');
        debugPrint('HEADERS: ${e.response?.headers}');
      } else {
        debugPrint('Error sending request!');
        debugPrint(e.message);
      }
    }
    return user;
  }

  Future<Register?> postRegister(String username, String email, String name, String password) async {
    Register? user;

    try {
      var response = await _dio.post("$_baseUrl/register",
          options: Options(headers: {"API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j"}),
          data: {"username": username, "email": email, "name": name, "password": password});
      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        user = Register.fromJson(data);
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
      // if (e.response != null) {
      //   if (e.response?.statusCode == 400) {
      //     user?.message = e.response?.data['message'];
      //     print(user?.message);
      //   }
      //   debugPrint('Dio error!');
      //   debugPrint('STATUS: ${e.response?.statusCode}');
      //   debugPrint('DATA: ${e.response?.data}');
      //   debugPrint('HEADERS: ${e.response?.headers}');
      // } else {
      //   debugPrint('Error sending request!');

      // }
    }
    return user;
  }
}
