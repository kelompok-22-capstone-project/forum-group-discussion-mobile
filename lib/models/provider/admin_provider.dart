import 'package:flutter/material.dart';
import 'package:moot/models/admin.dart';
import 'package:moot/models/api/service.dart';

import 'package:moot/models/report.dart';

enum AdminProviderState { none, loading, error }

class AdminProvider extends ChangeNotifier {
  AdminProviderState _state = AdminProviderState.none;
  AdminProviderState get state => _state;

  String? errorMessage;

  Admin? _adminData;
  Admin? get adminData => _adminData;

  bool _isBan = false;
  bool get isBan => _isBan;

  List<ReportData>? _report = [];
  List<ReportData>? get report => _report;

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

  Future<void> getAllReport(String status, int page, int limit) async {
    changeState(AdminProviderState.loading);
    try {
      List<ReportData>? reportApi = await service.getAllReport(status, page, limit);
      _report = reportApi;
      changeState(AdminProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(AdminProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> putBanUser(String username) async {
    changeState(AdminProviderState.loading);
    try {
      bool reportApi = await service.putBanUser(username);
      _isBan = reportApi;
      changeState(AdminProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(AdminProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }
}
