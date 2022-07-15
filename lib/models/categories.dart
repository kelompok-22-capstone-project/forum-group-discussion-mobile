class Categorie {
  String? status;
  String? message;
  ListCategorie? data;

  Categorie({this.status, this.message, this.data});

  Categorie.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? ListCategorie.fromJson(json['data']) : null;
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

class ListCategorie {
  List<Categories>? categories;

  ListCategorie({this.categories});

  ListCategorie.fromJson(Map<String, dynamic> json) {
    if (json['categories'] != null) {
      categories = <Categories>[];
      json['categories'].forEach((v) {
        categories!.add(Categories.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (categories != null) {
      data['categories'] = categories!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Categories {
  String? iD;
  String? name;
  String? description;
  String? createdOn;

  Categories({this.iD, this.name, this.description, this.createdOn});

  Categories.fromJson(Map<String, dynamic> json) {
    iD = json['ID'];
    name = json['name'];
    description = json['description'];
    createdOn = json['createdOn'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['ID'] = iD;
    data['name'] = name;
    data['description'] = description;
    data['createdOn'] = createdOn;
    return data;
  }
}
