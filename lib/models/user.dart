class User {
  String? status;
  String? message;
  UserData? data;

  User({this.status, this.message, this.data});

  User.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? UserData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class UserData {
  String? userID;
  String? username;
  bool? isFollowed;
  String? email;
  String? name;
  String? role;
  bool? isActive;
  String? registeredOn;
  int? totalThread;
  int? totalFollower;
  int? totalFollowing;

  UserData(
      {this.userID,
      this.username,
      this.isFollowed,
      this.email,
      this.name,
      this.role,
      this.isActive,
      this.registeredOn,
      this.totalThread,
      this.totalFollower,
      this.totalFollowing});

  UserData.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    username = json['username'];
    isFollowed = json['isFollowed'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    isActive = json['isActive'];
    registeredOn = json['registeredOn'];
    totalThread = json['totalThread'];
    totalFollower = json['totalFollower'];
    totalFollowing = json['totalFollowing'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['username'] = username;
    data['isFollowed'] = isFollowed;
    data['email'] = email;
    data['name'] = name;
    data['role'] = role;
    data['isActive'] = isActive;
    data['registeredOn'] = registeredOn;
    data['totalThread'] = totalThread;
    data['totalFollower'] = totalFollower;
    data['totalFollowing'] = totalFollowing;
    return data;
  }
}

class UserList {
  String? status;
  String? message;
  Data? data;

  UserList({this.status, this.message, this.data});

  UserList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ListUsers>? list;
  PageInfo? pageInfo;

  Data({this.list, this.pageInfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ListUsers>[];
      json['list'].forEach((v) {
        list!.add(ListUsers.fromJson(v));
      });
    }
    pageInfo = json['pageInfo'] != null ? PageInfo.fromJson(json['pageInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (list != null) {
      data['list'] = list!.map((v) => v.toJson()).toList();
    }
    if (pageInfo != null) {
      data['pageInfo'] = pageInfo!.toJson();
    }
    return data;
  }
}

class ListUsers {
  String? userID;
  String? username;
  String? email;
  String? name;
  String? role;
  bool? isActive;
  String? registeredOn;
  int? totalThread;
  int? totalFollower;
  int? totalFollowing;
  bool? isFollowed;

  ListUsers(
      {this.userID,
      this.username,
      this.email,
      this.name,
      this.role,
      this.isActive,
      this.registeredOn,
      this.totalThread,
      this.totalFollower,
      this.totalFollowing,
      this.isFollowed});

  ListUsers.fromJson(Map<String, dynamic> json) {
    userID = json['userID'];
    username = json['username'];
    email = json['email'];
    name = json['name'];
    role = json['role'];
    isActive = json['isActive'];
    registeredOn = json['registeredOn'];
    totalThread = json['totalThread'];
    totalFollower = json['totalFollower'];
    totalFollowing = json['totalFollowing'];
    isFollowed = json['isFollowed'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['userID'] = userID;
    data['username'] = username;
    data['email'] = email;
    data['name'] = name;
    data['role'] = role;
    data['isActive'] = isActive;
    data['registeredOn'] = registeredOn;
    data['totalThread'] = totalThread;
    data['totalFollower'] = totalFollower;
    data['totalFollowing'] = totalFollowing;
    data['isFollowed'] = isFollowed;
    return data;
  }
}

class PageInfo {
  int? limit;
  int? page;
  int? pageTotal;
  int? total;

  PageInfo({this.limit, this.page, this.pageTotal, this.total});

  PageInfo.fromJson(Map<String, dynamic> json) {
    limit = json['limit'];
    page = json['page'];
    pageTotal = json['pageTotal'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['limit'] = limit;
    data['page'] = page;
    data['pageTotal'] = pageTotal;
    data['total'] = total;
    return data;
  }
}
