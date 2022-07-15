import 'package:flutter/material.dart';
import 'package:moot/models/admin.dart';
import 'package:moot/models/api/service.dart';
import 'package:moot/models/categories.dart';
import 'package:moot/models/thread.dart';
import 'package:moot/models/user.dart';

enum AdminProviderState { none, loading, error }

class AdminProvider extends ChangeNotifier {
  AdminProviderState _state = AdminProviderState.none;
  AdminProviderState get state => _state;

  String? errorMessage;

  Admin? _adminData;
  Admin? get adminData => _adminData;

  final ApiService service = ApiService();

  addDetailFoods() {}

  changeState(AdminProviderState state) {
    _state = state;
    notifyListeners();
  }

  Future<void> getAdminDashboar() async {
    changeState(AdminProviderState.loading);

    try {
      Admin? adminApi = await service.getAdminDasboard();
      _adminData = adminApi;
      print(adminApi?.data?.totalReport);
      changeState(AdminProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(AdminProviderState.error);
      print('error bos $e');
    }
  }
}
