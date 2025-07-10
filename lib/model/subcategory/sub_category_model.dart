

class SubCategoryModel {
  bool? success;
  List<SubCategory>? data;

  SubCategoryModel({this.success, this.data});

  SubCategoryModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <SubCategory>[];
      json['data'].forEach((v) {
        data!.add(new SubCategory.fromJson(v));
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

class SubCategory {
  String? categoryId;
  String? subcategoryName;
  String? image;
  String? userId;
  String? status;
  String? id;

  SubCategory(
      {this.categoryId,
        this.subcategoryName,
        this.image,
        this.userId,
        this.id,this.status});

  SubCategory.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    subcategoryName = json['subcategoryName'];
    image = json['image'];
    userId = json['userId'];
    status = json['status'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['categoryId'] = this.categoryId;
    data['subcategoryName'] = this.subcategoryName;
    data['image'] = this.image;
    data['userId'] = this.userId;
    data['id'] = this.id;
    return data;
  }
}
