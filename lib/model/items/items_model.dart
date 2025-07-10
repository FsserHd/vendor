
class ItemModel {
  bool? success;
  List<Data>? data;
  String? message;

  ItemModel({this.success, this.data, this.message});

  ItemModel.fromJson(Map<String, dynamic> json) {
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
  String? id;
  String? categoryName;
  List<Productdetails>? productdetails;

  Data({this.id, this.categoryName, this.productdetails});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    if (json['productdetails'] != null) {
      productdetails = <Productdetails>[];
      json['productdetails'].forEach((v) {
        productdetails!.add(new Productdetails.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['categoryName'] = this.categoryName;
    if (this.productdetails != null) {
      data['productdetails'] =
          this.productdetails!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Productdetails {
  String? id;
  String? productName;
  Variant? variant;
  String? productType;
  bool? status;
  String? fromTime;
  String? toTime;

  Productdetails(
      {this.id,
        this.productName,
        this.variant,
        this.productType,
        this.status,
        this.fromTime,
        this.toTime});

  Productdetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    variant =
    json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
    productType = json['productType'];
    status = json['status'];
    fromTime = json['fromTime'];
    toTime = json['toTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    if (this.variant != null) {
      data['variant'] = this.variant!.toJson();
    }
    data['productType'] = this.productType;
    data['status'] = this.status;
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    return data;
  }
}

class Variant {
  String? variantId;
  String? productId;
  String? quantity;
  String? name;
  String? unit;
  String? salePrice;
  String? strikePrice;
  String? packingCharge;
  String? tax;
  String? taxPercentage;
  int? discount;
  String? type;
  String? foodType;
  String? itemType;
  bool? selected;
  String? uploadImage;

  Variant(
      {this.variantId,
        this.productId,
        this.quantity,
        this.name,
        this.unit,
        this.salePrice,
        this.strikePrice,
        this.tax,
        this.taxPercentage,
        this.discount,
        this.foodType,
        this.type,
        this.itemType,
        this.selected,
        this.uploadImage,this.packingCharge});

  Variant.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    name = json['name'];
    unit = json['unit'];
    salePrice = json['sale_price'];
    strikePrice = json['strike_price'];
    taxPercentage = json['tax_percent'];
    tax = json['tax'];
    discount = json['discount'];
    type = json['type'];
    itemType = json['itemType'];
    selected = json['selected'];
    uploadImage = json['uploadImage'];
    foodType = json['food_type'];
    packingCharge = json['packing_charges'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variantId;
    data['product_id'] = this.productId;
    data['quantity'] = this.quantity;
    data['name'] = this.name;
    data['unit'] = this.unit;
    data['sale_price'] = this.salePrice;
    data['strike_price'] = this.strikePrice;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['type'] = this.type;
    data['itemType'] = this.itemType;
    data['selected'] = this.selected;
    data['uploadImage'] = this.uploadImage;
    data['packing_charges'] = this.packingCharge;

    return data;
  }
}
