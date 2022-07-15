class Thread {
  String? status;
  String? message;
  Data? data;

  Thread({this.status, this.message, this.data});

  Thread.fromJson(Map<String, dynamic> json) {
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
  List<ThreadData>? list;
  PageInfo? pageInfo;

  Data({this.list, this.pageInfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ThreadData>[];
      json['list'].forEach((v) {
        list!.add(ThreadData.fromJson(v));
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

class ThreadData {
  String? iD;
  String? title;
  int? totalFollower;
  int? totalComment;
  String? creatorID;
  String? creatorUsername;
  String? creatorName;
  String? categoryID;
  String? categoryName;
  String? publishedOn;
  bool? isLiked;
  bool? isFollowed;
  String? description;
  int? totalViewer;
  int? totalLike;

  ThreadData(
      {this.iD,
      this.title,
      this.totalFollower,
      this.totalComment,
      this.creatorID,
      this.creatorUsername,
      this.creatorName,
      this.categoryID,
      this.categoryName,
      this.publishedOn,
      this.isLiked,
      this.isFollowed,
      this.description,
      this.totalViewer,
      this.totalLike});

  ThreadData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    title = json['title'];
    totalFollower = json['totalFollower'];
    totalComment = json['totalComment'];
    creatorID = json['creatorID'];
    creatorUsername = json['creatorUsername'];
    creatorName = json['creatorName'];
    categoryID = json['categoryID'];
    categoryName = json['categoryName'];
    publishedOn = json['publishedOn'];
    isLiked = json['isLiked'];
    isFollowed = json['isFollowed'];
    description = json['description'];
    totalViewer = json['totalViewer'];
    totalLike = json['totalLike'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['title'] = title;
    data['totalFollower'] = totalFollower;
    data['totalComment'] = totalComment;
    data['creatorID'] = creatorID;
    data['creatorUsername'] = creatorUsername;
    data['creatorName'] = creatorName;
    data['categoryID'] = categoryID;
    data['categoryName'] = categoryName;
    data['publishedOn'] = publishedOn;
    data['isLiked'] = isLiked;
    data['isFollowed'] = isFollowed;
    data['description'] = description;
    data['totalViewer'] = totalViewer;
    data['totalLike'] = totalLike;
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

class PostThread {
  String? status;
  String? message;
  ThreadPostData? data;

  PostThread({this.status, this.message, this.data});

  PostThread.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ThreadPostData.fromJson(json['data']) : null;
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

class ThreadPostData {
  String? iD;

  ThreadPostData({this.iD});

  ThreadPostData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    return data;
  }
}
