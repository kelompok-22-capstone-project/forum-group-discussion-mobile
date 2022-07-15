import 'package:flutter/material.dart';
import 'package:moot/models/api/service.dart';
import 'package:moot/models/comment.dart';
import 'package:moot/models/thread.dart';
import 'package:moot/models/user.dart';

enum ThreadProviderState { none, loading, error }

class ThreadProvider extends ChangeNotifier {
  ThreadProviderState _state = ThreadProviderState.none;
  ThreadProviderState get state => _state;

  String? errorMessage;

  int _tabIndex = 0;
  int get tabIndex => _tabIndex;

  bool _searchBool = false;
  bool get searchBool => _searchBool;

  bool _cekPutBool = false;
  bool get cekPutBool => _cekPutBool;

  String _searchText = "";
  String get searchText => _searchText;

  PostThread? _postThread;
  PostThread? get postThread => _postThread;

  List<ThreadData>? _thread = [];
  List<ThreadData>? get thread => _thread;

  List<ListData>? _comment = [];
  List<ListData>? get comment => List.unmodifiable(_comment!);

  List<ListUsers>? _users = [];
  List<ListUsers>? get users => List.unmodifiable(_users!);

  final ApiService service = ApiService();

  addDetailFoods() {}

  changeState(ThreadProviderState state) {
    _state = state;
    notifyListeners();
  }

  changeTabIndex(int index) {
    _tabIndex = index;
    notifyListeners();
  }

  setSearchText(bool searchBool, String searchText) {
    _searchBool = searchBool;
    _searchText = searchText;
    notifyListeners();
  }

  Future<void> getAllThread(int page, int limit, String search) async {
    changeState(ThreadProviderState.loading);
    try {
      List<ThreadData>? threadApi = await service.getThread(page, limit, search);
      _thread = threadApi;
      changeState(ThreadProviderState.none);
      notifyListeners();
      print("ini thread : ${threadApi![0].title}");
    } catch (e) {
      changeState(ThreadProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> putLikeThread(String id) async {
    changeState(ThreadProviderState.loading);
    try {
      bool threadApi = await service.putLikeThread(id);
      _cekPutBool = threadApi;
      changeState(ThreadProviderState.none);
      notifyListeners();
      print("ini putlike");
    } catch (e) {
      changeState(ThreadProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> putFollowThread(String id) async {
    changeState(ThreadProviderState.loading);
    try {
      bool threadApi = await service.putFollowThread(id);
      _cekPutBool = threadApi;
      changeState(ThreadProviderState.none);
      notifyListeners();
      print("ini putlike");
    } catch (e) {
      changeState(ThreadProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> getCommentThreadById(String id, int page, int limit) async {
    changeState(ThreadProviderState.loading);
    try {
      List<ListData>? commentApi = await service.getThreadComment(id, page, limit);
      _comment = commentApi;
      changeState(ThreadProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(ThreadProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<void> postThreadUser(String title, String desc, String id) async {
    changeState(ThreadProviderState.loading);
    try {
      PostThread? threadApi = await service.postThread(title, desc, id);
      _postThread = threadApi;
      changeState(ThreadProviderState.none);
      notifyListeners();
    } catch (e) {
      changeState(ThreadProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }

  Future<bool> postComment(String id, String comment) async {
    changeState(ThreadProviderState.loading);
    try {
      bool cek = await service.postComment(id, comment);
      if (cek) {
        await getCommentThreadById(id, 1, 20);
        changeState(ThreadProviderState.none);
        notifyListeners();
        return true;
      }
    } catch (e) {
      changeState(ThreadProviderState.error);
      print('error bos $e');
      errorMessage = e.toString();
      notifyListeners();
    }
    return false;
  }

  Future<void> getAllUsers(int page, int limit, String orderBy, String status, String keyword) async {
    changeState(ThreadProviderState.loading);
    try {
      List<ListUsers>? userApi = await service.getAllUsers(page, limit, orderBy, status, keyword);
      _users = userApi;
      changeState(ThreadProviderState.none);
      notifyListeners();
      print("ini user : ${userApi![0].name}");
    } catch (e) {
      changeState(ThreadProviderState.error);
      print('error bos $e');
      notifyListeners();
    }
  }
}
