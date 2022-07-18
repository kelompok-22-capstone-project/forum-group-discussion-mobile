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

  bool _enabledButton = false;
  bool get enableButton => _enabledButton;

  bool _cekPutBool = false;
  bool get cekPutBool => _cekPutBool;

  PostThread? _postThread;
  PostThread? get postThread => _postThread;

  List<Categories>? _categorie = [];
  List<Categories>? get categorie => List.unmodifiable(_categorie!);

  List<ThreadData>? _thread = [];
  List<ThreadData>? get thread => List.unmodifiable(_thread!);

  List<Categories>? _baru = [];
  List<Categories>? get baru => List.unmodifiable(_baru!);

  final ApiService service = ApiService();

  List _dropdownItemList = [];

  List get dropDownItemList => List.unmodifiable(_dropdownItemList);

  changeState(CategorieProviderState state) {
    _state = state;
    notifyListeners();
  }

  search(String search) {
    changeState(CategorieProviderState.loading);

    if (search == "") {
      _baru = [];
    }
    List<Categories>? temp = [];
    _categorie?.forEach((element) {
      if (element.name!.toLowerCase().contains(search)) {
        temp.add(element);
      }
    });
    _baru = temp;
    changeState(CategorieProviderState.none);
    if (temp.isEmpty) {
      changeState(CategorieProviderState.error);
    }
    notifyListeners();
  }

  changeButton(bool isEnable) {
    _enabledButton = isEnable;
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

  Future<void> postCategory(String title, String desc) async {
    changeState(CategorieProviderState.loading);
    try {
      PostThread? threadApi = await service.postCategory(title, desc);
      _postThread = threadApi;
      changeState(CategorieProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(CategorieProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> deleteCategorie(String id) async {
    changeState(CategorieProviderState.loading);
    try {
      bool threadApi = await service.deleteCategory(id);
      print("thread : $threadApi");
      _cekPutBool = threadApi;
      changeState(CategorieProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(CategorieProviderState.error);
      print('error bos $e');
      notifyListeners();
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

  Future<void> putUpdateCategorie(String id, String name, String desc) async {
    changeState(CategorieProviderState.loading);
    try {
      await service.putUpdateCategory(id, name, desc);
      changeState(CategorieProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(CategorieProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }
}
