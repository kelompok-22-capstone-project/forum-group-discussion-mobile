import 'package:flutter/material.dart';
import 'package:moot/models/api/service.dart';
import 'package:moot/models/categories.dart';
import 'package:moot/models/comment.dart';
import 'package:moot/models/thread.dart';
import 'package:moot/models/user.dart';

enum UserProviderState { none, loading, error }

class UserProvider extends ChangeNotifier {
  UserProviderState _state = UserProviderState.none;
  UserProviderState get state => _state;

  String? errorMessage;

  User? _userData;
  User? get userData => _userData;

  User? _userFriendData;
  User? get userFriendData => _userFriendData;

  bool _isFriend = false;
  bool get isFriend => _isFriend;

  List<ThreadData>? _thread = [];
  List<ThreadData>? get thread => List.unmodifiable(_thread!);

  List<ListUsers>? _users = [];
  List<ListUsers>? get users => List.unmodifiable(_users!);

  final ApiService service = ApiService();

  addDetailFoods() {}

  changeState(UserProviderState state) {
    _state = state;
    notifyListeners();
  }

  changeIsFriend(bool isFriend) {
    _isFriend = isFriend;
    notifyListeners();
  }

  Future<void> getAllUsers(int page, int limit, String orderBy, String status, String keyword) async {
    changeState(UserProviderState.loading);
    try {
      List<ListUsers>? userApi = await service.getAllUsers(page, limit, orderBy, status, keyword);
      _users = userApi;
      print(userApi?[0].name);
      changeState(UserProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(UserProviderState.error);
      print('error bos 1 $e');
      notifyListeners();
    }
  }

  Future<void> getOwnProfile() async {
    changeState(UserProviderState.loading);

    try {
      User? UserApi = await service.getOwnUser();
      _userData = UserApi;
      print(UserApi?.data?.name);
      changeState(UserProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(UserProviderState.error);
      print('error bos 2 $e');
      notifyListeners();
    }
  }

  Future<void> getUserByUsername(String username) async {
    changeState(UserProviderState.loading);

    try {
      User? UserApi = await service.getUserByUsername(username);
      _userFriendData = UserApi;
      changeState(UserProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(UserProviderState.error);
      print('error bos 2 $e');
      notifyListeners();
    }
  }

  Future<void> getThreadByUsername(String username, int page, int limit) async {
    changeState(UserProviderState.loading);
    try {
      List<ThreadData>? threadApi = await service.getThreadByUsername(username, page, limit);
      _thread = threadApi;
      changeState(UserProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(UserProviderState.error);
      print('error bos 3 $e');
      notifyListeners();
    }
  }
}
