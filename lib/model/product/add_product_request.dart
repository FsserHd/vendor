
class AddProductRequest {
  String? productTitle;
  int? category =0;
  double? salePrice;
  int? tax;
  Null? discount;
  int? quantity;
  String? description;
  int? vendor;
  int? subCategory;
  double? strikePrice;
  String? unit;
  int? stock;

  AddProductRequest(
      {this.productTitle,
        this.category,
        this.salePrice,
        this.tax,
        this.discount,
        this.quantity,
        this.description,
        this.vendor,
        this.subCategory,
        this.strikePrice,
        this.unit,
        this.stock});

  AddProductRequest.fromJson(Map<String, dynamic> json) {
    productTitle = json['productTitle'];
    category = json['category'];
    salePrice = json['salePrice'];
    tax = json['tax'];
    discount = json['discount'];
    quantity = json['quantity'];
    description = json['description'];
    vendor = json['vendor'];
    subCategory = json['subCategory'];
    strikePrice = json['strikePrice'];
    unit = json['unit'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['productTitle'] = this.productTitle;
    data['category'] = this.category;
    data['salePrice'] = this.salePrice;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['quantity'] = this.quantity;
    data['description'] = this.description;
    data['vendor'] = this.vendor;
    data['subCategory'] = this.subCategory;
    data['strikePrice'] = this.strikePrice;
    data['unit'] = this.unit;
    data['stock'] = this.stock;
    return data;
  }
}
