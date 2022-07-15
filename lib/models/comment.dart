class Comment {
  String? status;
  String? message;
  Data? data;

  Comment({this.status, this.message, this.data});

  Comment.fromJson(Map<String, dynamic> json) {
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
  List<ListData>? list;
  PageInfo? pageInfo;

  Data({this.list, this.pageInfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ListData>[];
      json['list'].forEach((v) {
        list!.add(ListData.fromJson(v));
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

class ListData {
  String? iD;
  String? userID;
  String? username;
  String? name;
  String? comment;
  String? publishedOn;

  ListData({this.iD, this.userID, this.username, this.name, this.comment, this.publishedOn});

  ListData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    userID = json['userID'];
    username = json['username'];
    name = json['name'];
    comment = json['comment'];
    publishedOn = json['publishedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['userID'] = userID;
    data['username'] = username;
    data['name'] = name;
    data['comment'] = comment;
    data['publishedOn'] = publishedOn;
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

class PostComment {
  String? status;
  String? message;
  CommentData? commentData;

  PostComment({this.status, this.message, this.commentData});

  PostComment.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    commentData = json['data'] != null ? CommentData.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (commentData != null) {
      data['data'] = commentData!.toJson();
    }
    return data;
  }
}

class CommentData {
  String? iD;

  CommentData({this.iD});

  CommentData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    return data;
  }
}
