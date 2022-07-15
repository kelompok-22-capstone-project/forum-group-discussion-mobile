class Admin {
  String? status;
  String? message;
  AdminData? data;

  Admin({this.status, this.message, this.data});

  Admin.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? AdminData.fromJson(json['data']) : null;
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

class AdminData {
  int? totalUser;
  int? totalThread;
  int? totalModerator;
  int? totalReport;

  AdminData({this.totalUser, this.totalThread, this.totalModerator, this.totalReport});

  AdminData.fromJson(Map<String, dynamic> json) {
    totalUser = json['totalUser'];
    totalThread = json['totalThread'];
    totalModerator = json['totalModerator'];
    totalReport = json['totalReport'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['totalUser'] = totalUser;
    data['totalThread'] = totalThread;
    data['totalModerator'] = totalModerator;
    data['totalReport'] = totalReport;
    return data;
  }
}
