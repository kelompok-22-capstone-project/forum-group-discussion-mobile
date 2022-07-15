import 'package:flutter/foundation.dart';
import 'package:moot/models/api/service.dart';
import 'package:moot/models/login.dart';
import 'package:moot/models/register.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum AuthProviderState { none, loading, error }

class AuthProvider extends ChangeNotifier {
  final ApiService service = ApiService();

  AuthProviderState _state = AuthProviderState.none;
  AuthProviderState get state => _state;

  String? errorMessage;

  Login? _login;
  Login? get login => _login;

  Register? _register;
  Register? get register => _register;

  changeState(AuthProviderState state) {
    _state = state;
    notifyListeners();
  }

  Future<void>? loginUser(String username, String password) async {
    changeState(AuthProviderState.loading);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      Login? authApi = await service.postLogin(username, password);
      _login = authApi;
      final String? token = _login?.data?.token;
      final String? role = _login?.data?.role;
      await prefs.setString('token', token!);
      await prefs.setString('role', role!);
      changeState(AuthProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(AuthProviderState.error);
      errorMessage = e.toString();
      print('error bos $e');
    }
  }

  Future<void>? registUser(String username, String email, String name, String password) async {
    changeState(AuthProviderState.loading);
    try {
      Register? authApi = await service.postRegister(username, email, name, password);
      _register = authApi;

      changeState(AuthProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(AuthProviderState.error);
      errorMessage = e.toString();
    }
  }

  Future<void>? logoutUser() async {
    changeState(AuthProviderState.loading);
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.clear();

      _login = null;
      final String? contactsString = prefs.getString('token');
      print(contactsString);
      changeState(AuthProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(AuthProviderState.error);
      print('error bos $e');
    }
  }
}
