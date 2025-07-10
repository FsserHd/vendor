class DiscountModel {
  bool? success;
  String? message;
  Data? data;

  DiscountModel({this.success, this.message, this.data});

  DiscountModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class Data {
  String? discount;
  String? discountType;
  String? upTo;

  Data({this.discount, this.discountType});

  Data.fromJson(Map<String, dynamic> json) {
    discount = json['discount'];
    discountType = json['discount_type'];
    upTo = json['upTo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['discount'] = this.discount;
    data['discount_type'] = this.discountType;
    return data;
  }
}
