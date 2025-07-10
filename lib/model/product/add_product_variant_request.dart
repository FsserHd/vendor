

class AddProductVariantRequest {
  int? variantId;
  double? salePrice;
  double? strikePrice;
  int? quantity;
  String? unit;
  int? vendor;
  String? foodType;
  int? tax;
  Null? discount;

  AddProductVariantRequest(
      {this.variantId,
        this.salePrice,
        this.strikePrice,
        this.quantity,
        this.unit,
        this.vendor,
        this.foodType,
        this.tax,
        this.discount});

  AddProductVariantRequest.fromJson(Map<String, dynamic> json) {
    variantId = json['variant_id'];
    salePrice = json['salePrice'];
    strikePrice = json['strikePrice'];
    quantity = json['quantity'];
    unit = json['unit'];
    vendor = json['vendor'];
    foodType = json['foodType'];
    tax = json['tax'];
    discount = json['discount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['variant_id'] = this.variantId;
    data['salePrice'] = this.salePrice;
    data['strikePrice'] = this.strikePrice;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['vendor'] = this.vendor;
    data['foodType'] = this.foodType;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    return data;
  }
}
