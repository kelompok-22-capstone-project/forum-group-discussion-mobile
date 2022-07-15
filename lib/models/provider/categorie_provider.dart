import 'package:flutter/material.dart';
import 'package:moot/models/api/service.dart';
import 'package:moot/models/categories.dart';
import 'package:moot/models/thread.dart';
import 'package:moot/models/user.dart';

enum CategorieProviderState { none, loading, error }

class CategorieProvider extends ChangeNotifier {
  CategorieProviderState _state = CategorieProviderState.none;
  CategorieProviderState get state => _state;

  String? errorMessage;

  double heightCategory = 0.3;

  User? _userData;
  User? get userData => _userData;

  List<Categories>? _categorie = [];
  List<Categories>? get categorie => List.unmodifiable(_categorie!);

  List<ThreadData>? _thread = [];
  List<ThreadData>? get thread => List.unmodifiable(_thread!);

  final ApiService service = ApiService();

  List _dropdownItemList = [];

  List get dropDownItemList => List.unmodifiable(_dropdownItemList);

  addDetailFoods() {}

  changeState(CategorieProviderState state) {
    _state = state;
    notifyListeners();
  }

  changeHeight() {
    if (heightCategory == 0.3) {
      heightCategory = 0.5;
      notifyListeners();
    } else if (heightCategory == 0.5) {
      heightCategory = 0.3;
      notifyListeners();
    }
  }

  Future<void> getThreadByCategoryId(String id, int page, int limit) async {
    changeState(CategorieProviderState.loading);
    try {
      List<ThreadData>? threadApi = await service.getThreadByCategoryId(id, page, limit);
      _thread = threadApi;
      changeState(CategorieProviderState.none);
      notifyListeners();
      print("ini thread : ${threadApi![0].title}");
    } catch (e) {
      changeState(CategorieProviderState.error);
      print('error bos $e');
    }
  }

  Future<void> getAllCategorie() async {
    changeState(CategorieProviderState.loading);

    try {
      List<Categories>? categorieApi = await service.getAllCategories();
      _categorie = categorieApi;
      List temp = categorieApi?.map((e) => {'label': e.name, 'value': e.iD}).toList() as List;
      _dropdownItemList = [...temp];
      changeState(CategorieProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(CategorieProviderState.error);
      print('error bos $e');
    }
  }

  Future<void> getOwnProfile() async {
    changeState(CategorieProviderState.loading);

    try {
      User? UserApi = await service.getOwnUser();
      _userData = UserApi;
      print(UserApi?.data?.name);
      changeState(CategorieProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(CategorieProviderState.error);
      print('error bos $e');
    }
  }
}
