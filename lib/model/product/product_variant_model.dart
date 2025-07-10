

class ProductVariantModel {
  bool? success;
  List<ProductVariant>? data;
  String? message;

  ProductVariantModel({this.success, this.data, this.message});

  ProductVariantModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <ProductVariant>[];
      json['data'].forEach((v) {
        data!.add(new ProductVariant.fromJson(v));
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

class ProductVariant {
  String? variantId;
  String? productId;
  String? quantity;
  String? name;
  String? unit;
  String? salePrice;
  String? strikePrice;
  String? tax;
  String? taxPercentage;
  int? discount;
  String? type;
  bool? selected;
  String? uploadImage;

  ProductVariant(
      {this.variantId,
        this.productId,
        this.quantity,
        this.name,
        this.unit,
        this.salePrice,
        this.strikePrice,
        this.tax,
        this.discount,
        this.type,
        this.selected,
        this.uploadImage,this.taxPercentage});

  ProductVariant.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    productId = json['product_id'];
    quantity = json['quantity'];
    name = json['name'];
    unit = json['unit'];
    salePrice = json['sale_price'];
    strikePrice = json['strike_price'];
    tax = json['tax'];
    taxPercentage = json['tax_percent'];
    discount = json['discount'];
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
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['type'] = this.type;
    data['selected'] = this.selected;
    data['uploadImage'] = this.uploadImage;
    return data;
  }
}
