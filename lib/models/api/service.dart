import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:moot/models/admin.dart';
import 'package:moot/models/categories.dart';
import 'package:moot/models/comment.dart';
import 'package:moot/models/error_Respond.dart';
import 'package:moot/models/login.dart';
import 'package:moot/models/register.dart';
import 'package:moot/models/thread.dart';
import 'package:moot/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ApiService {
  final Dio _dio = Dio();

  // ApiService() {
  //   _dio.interceptors.add(LogInterceptor(responseBody: true, requestBody: true));
  // }

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
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
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
    }
    return user;
  }

  Future<PostThread?> postThread(String title, String desc, String categoriId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    PostThread? thread;

    try {
      var response = await _dio.post("$_baseUrl/threads",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token"
          }),
          data: {"title": title, "description": desc, "categoryID": categoriId});
      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        thread = PostThread.fromJson(data);
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return thread;
  }

  Future<List<ThreadData>?> getThread(int page, int limit, String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    List<ThreadData>? thread = [];

    try {
      var response = await _dio.get("$_baseUrl/threads",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token"
          }),
          queryParameters: {"page": page, "limit": limit, "search": search});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List listData = data["data"]["list"];
        thread = listData.map((e) => ThreadData.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return thread;
  }

  Future<List<ThreadData>?> getThreadByUsername(String username, int page, int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    List<ThreadData>? thread = [];

    try {
      var response = await _dio.get("$_baseUrl/users/$username/threads",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token"
          }),
          queryParameters: {"username": username, "page": page, "limit": limit});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List listData = data["data"]["list"];
        thread = listData.map((e) => ThreadData.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return thread;
  }

  Future<List<ListData>?> getThreadComment(String id, int page, int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    List<ListData>? comment = [];

    try {
      var response = await _dio.get("$_baseUrl/threads/$id/comments",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token"
          }),
          queryParameters: {"page": page, "limit": limit});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List listData = data["data"]["list"];
        comment = listData.map((e) => ListData.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return comment;
  }

  Future<bool> postComment(String id, String comment) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');

    try {
      var response = await _dio.post("$_baseUrl/threads/$id/comments",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token",
          }),
          data: {"comment": comment});
      if (response.statusCode == 201) {
        Map<String, dynamic> data = response.data;
        print('success bos');
        return true;
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return false;
  }

  Future<List<Categories>?> getAllCategories() async {
    List<Categories>? comment = [];

    try {
      var response = await _dio.get("$_baseUrl/categories",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
          }));
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List listData = data["data"]["categories"];
        comment = listData.map((e) => Categories.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return comment;
  }

  Future<bool> putLikeThread(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      var response = await _dio.put("$_baseUrl/threads/$id/like",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token"
          }));
      if (response.statusCode == 204) {
        return true;
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return false;
  }

  Future<bool> putFollowThread(String id) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    try {
      var response = await _dio.put("$_baseUrl/threads/$id/follow",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token"
          }));
      if (response.statusCode == 204) {
        return true;
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return false;
  }

  Future<List<ThreadData>?> getThreadByCategoryId(String id, int page, int limit) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    List<ThreadData>? thread = [];

    try {
      var response = await _dio.get("$_baseUrl/categories/$id/threads",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token"
          }),
          queryParameters: {"page": page, "limit": limit});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List listData = data["data"]["list"];
        thread = listData.map((e) => ThreadData.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return thread;
  }

  Future<List<ListUsers>?> getAllUsers(int page, int limit, String orderBy, String status, String keyword) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    List<ListUsers>? users = [];

    try {
      var response = await _dio.get("$_baseUrl/users",
          options: Options(headers: {
            "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
            "Authorization": "Bearer $token"
          }),
          queryParameters: {"page": page, "limit": limit, "order_by": orderBy, "status": status, "keyword": keyword});
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        List listData = data["data"]["list"];
        users = listData.map((e) => ListUsers.fromJson(e)).toList();
      }
    } on DioError catch (e) {
      final defaultError = ErrorRespond.fromJson(e.response?.data);
      debugPrint(e.message);
      throw "${defaultError.message}";
    }
    return users;
  }

  Future<User?> getOwnUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    User? userData;

    try {
      var response = await _dio.get(
        "$_baseUrl/users/me",
        options: Options(headers: {
          "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
          "Authorization": "Bearer $token"
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        User userData = User.fromJson(data);
        print(userData.data?.username);
        return userData;
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
    return userData;
  }

  Future<User?> getUserByUsername(String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    User? userData;

    try {
      var response = await _dio.get(
        "$_baseUrl/users/$username",
        options: Options(headers: {
          "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
          "Authorization": "Bearer $token"
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        User userData = User.fromJson(data);
        print(userData.data?.username);
        return userData;
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
    return userData;
  }

  Future<Admin?> getAdminDasboard() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    Admin? adminData;

    try {
      var response = await _dio.get(
        "$_baseUrl/admin/dashboard",
        options: Options(headers: {
          "API-Key": "2ry3HBOBLi1YkCma49pdnH3RpMguwgNZ1bvU2eqCOzZg2y0g2j",
          "Authorization": "Bearer $token"
        }),
      );
      if (response.statusCode == 200) {
        Map<String, dynamic> data = response.data;
        Admin adminData = Admin.fromJson(data);
        print(adminData.data?.totalUser);
        return adminData;
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
    return adminData;
  }
}
