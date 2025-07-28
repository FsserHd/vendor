
class AddItemRequest {
  String? fromTime;
  String? toTime;
  String? description;
  String? quantity;
  String? unit;
  String? salePrice;
  String? strikePrice;
  String? vendor;
  String? foodType;
  String? packingCharge;
  String? tax;
  String? discount;
  String? category;
  String? varientId;
  String? productId;
  String? title;
  String? startTime;
  String? endTime;

  AddItemRequest(
      {this.fromTime,
        this.toTime,
        this.description,
        this.quantity,
        this.unit,
        this.salePrice,
        this.strikePrice,
        this.vendor,
        this.foodType,
        this.packingCharge,
        this.tax,
        this.discount,this.category,this.title,this.varientId,this.endTime,this.startTime});

  AddItemRequest.fromJson(Map<String, dynamic> json) {
    fromTime = json['fromTime'];
    toTime = json['toTime'];
    description = json['description'];
    quantity = json['quantity'];
    unit = json['unit'];
    salePrice = json['salePrice'];
    strikePrice = json['strikePrice'];
    vendor = json['vendor'];
    foodType = json['foodType'];
    packingCharge = json['packingCharge'];
    tax = json['tax'];
    discount = json['discount'];
    category = json['category'];
    title = json['title'];
    startTime = json['startTime'];
    endTime = json['endTime'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fromTime'] = this.fromTime;
    data['toTime'] = this.toTime;
    data['description'] = this.description;
    data['quantity'] = this.quantity;
    data['unit'] = this.unit;
    data['salePrice'] = this.salePrice;
    data['strikePrice'] = this.strikePrice;
    data['vendor'] = this.vendor;
    data['foodType'] = this.foodType;
    data['packingCharge'] = this.packingCharge;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['varientId'] = this.varientId;
    data['productId'] = this.productId;
    data['title'] = this.title;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    return data;
  }
}
