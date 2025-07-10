

class ProductModel {
  bool? success;
  List<Product>? data;
  String? message;

  ProductModel({this.success, this.data, this.message});

  ProductModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Product>[];
      json['data'].forEach((v) {
        data!.add(new Product.fromJson(v));
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

class Product {
  String? id;
  String? categoryName;
  List<GroceryProductDetails>? productdetails;

  Product({this.id, this.categoryName, this.productdetails});

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    categoryName = json['categoryName'];
    if (json['productdetails'] != null) {
      productdetails = <GroceryProductDetails>[];
      json['productdetails'].forEach((v) {
        productdetails!.add(new GroceryProductDetails.fromJson(v));
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

class GroceryProductDetails {
  String? id;
  String? productName;
  Variant? variant;
  String? productType;
  bool? status;
  bool? todayDeals;

  GroceryProductDetails(
      {this.id,
        this.productName,
        this.variant,
        this.productType,
        this.status,
        this.todayDeals});

  GroceryProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    variant =
    json['variant'] != null ? new Variant.fromJson(json['variant']) : null;
    productType = json['productType'];
    status = json['status'];
    todayDeals = json['todayDeals'];
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
    data['todayDeals'] = this.todayDeals;
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
  String? type;
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
        this.type,
        this.selected,
        this.uploadImage});

  Variant.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    name = json['name'];
    unit = json['unit'];
    salePrice = json['sale_price'];
    strikePrice = json['strike_price'];
    type = json['type'];
    selected = json['selected'];
    uploadImage = json['uploadImage'];
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
    data['type'] = this.type;
    data['selected'] = this.selected;
    data['uploadImage'] = this.uploadImage;
    return data;
  }
}
