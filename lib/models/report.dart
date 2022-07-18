class Report {
  String? status;
  String? message;
  Data? data;

  Report({this.status, this.message, this.data});

  Report.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  List<ReportData>? list;
  PageInfo? pageInfo;

  Data({this.list, this.pageInfo});

  Data.fromJson(Map<String, dynamic> json) {
    if (json['list'] != null) {
      list = <ReportData>[];
      json['list'].forEach((v) {
        list!.add(new ReportData.fromJson(v));
      });
    }
    pageInfo = json['pageInfo'] != null ? new PageInfo.fromJson(json['pageInfo']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.list != null) {
      data['list'] = this.list!.map((v) => v.toJson()).toList();
    }
    if (this.pageInfo != null) {
      data['pageInfo'] = this.pageInfo!.toJson();
    }
    return data;
  }
}

class ReportData {
  String? iD;
  String? moderatorID;
  String? moderatorUsername;
  String? moderatorName;
  String? userID;
  String? username;
  String? name;
  String? reason;
  String? status;
  String? threadID;
  String? threadTitle;
  String? reportedOn;
  String? comment;
  String? commentPublishedOn;

  ReportData(
      {this.iD,
      this.moderatorID,
      this.moderatorUsername,
      this.moderatorName,
      this.userID,
      this.username,
      this.name,
      this.reason,
      this.status,
      this.threadID,
      this.threadTitle,
      this.reportedOn,
      this.comment,
      this.commentPublishedOn});

  ReportData.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    moderatorID = json['moderatorID'];
    moderatorUsername = json['moderatorUsername'];
    moderatorName = json['moderatorName'];
    userID = json['userID'];
    username = json['username'];
    name = json['name'];
    reason = json['reason'];
    status = json['status'];
    threadID = json['threadID'];
    threadTitle = json['threadTitle'];
    reportedOn = json['reportedOn'];
    comment = json['comment'];
    commentPublishedOn = json['commentPublishedOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['ID'] = this.iD;
    data['moderatorID'] = this.moderatorID;
    data['moderatorUsername'] = this.moderatorUsername;
    data['moderatorName'] = this.moderatorName;
    data['userID'] = this.userID;
    data['username'] = this.username;
    data['name'] = this.name;
    data['reason'] = this.reason;
    data['status'] = this.status;
    data['threadID'] = this.threadID;
    data['threadTitle'] = this.threadTitle;
    data['reportedOn'] = this.reportedOn;
    data['comment'] = this.comment;
    data['commentPublishedOn'] = this.commentPublishedOn;
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
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['limit'] = this.limit;
    data['page'] = this.page;
    data['pageTotal'] = this.pageTotal;
    data['total'] = this.total;
    return data;
  }
}
