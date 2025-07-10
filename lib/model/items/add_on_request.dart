

class AddOnRequest {
  String? productId;
  String? name;
  String? salesPrice;
  String? tax;
  String? foodType;
  String? stock;
  String? vendorId;

  AddOnRequest(
      {this.productId,
        this.name,
        this.salesPrice,
        this.tax,
        this.foodType,
        this.stock,
        this.vendorId});

  AddOnRequest.fromJson(Map<String, dynamic> json) {
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
