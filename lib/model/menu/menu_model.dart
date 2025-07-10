

class MenuModel {
  bool? success;
  List<Menu>? data;

  MenuModel({this.success, this.data});

  MenuModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Menu>[];
      json['data'].forEach((v) {
        data!.add(new Menu.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Menu {
  String? id;
  String? categoryName;
  String? status;
  String? image;
  String? userId;

  Menu({this.id, this.categoryName, this.status, this.image, this.userId});

  Menu.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    status = json['status'];
    image = json['image'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    data['status'] = this.status;
    data['image'] = this.image;
    data['userId'] = this.userId;
    return data;
  }
}
