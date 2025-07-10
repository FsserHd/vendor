class AddOnItemModel {
  bool? success;
  List<Data>? data;
  String? message;

  AddOnItemModel({this.success, this.data, this.message});

  AddOnItemModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? addonId;
  String? productId;
  String? name;
  String? salesPrice;
  String? tax;
  String? foodType;
  String? stock;
  String? vendorId;

  Data(
      {this.addonId,
        this.productId,
        this.name,
        this.salesPrice,
        this.tax,
        this.foodType,
        this.stock,
        this.vendorId});

  Data.fromJson(Map<String, dynamic> json) {
    addonId = json['addon_id'];
    productId = json['product_id'];
    name = json['name'];
    salesPrice = json['sales_price'];
    tax = json['tax'];
    foodType = json['food_type'];
    stock = json['stock'];
    vendorId = json['vendor_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addon_id'] = this.addonId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['sales_price'] = this.salesPrice;
    data['tax'] = this.tax;
    data['food_type'] = this.foodType;
    data['stock'] = this.stock;
    data['vendor_id'] = this.vendorId;
    return data;
  }
}
