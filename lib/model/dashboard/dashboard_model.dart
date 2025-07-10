class DashboardModel {
  int? vendor;
  int? shipped;
  int? accepted;
  int? placed;
  double? sale;
  String? zoneId;
  String? shopName;
  String? zonestatus;
  int? category;
  int? product;

  DashboardModel(
      {this.vendor,
        this.shipped,
        this.accepted,
        this.placed,
        this.sale,
        this.category,
        this.product,this.zoneId,this.zonestatus});

  DashboardModel.fromJson(Map<String, dynamic> json) {
    vendor = json['vendor'];
    shipped = json['Shipped'];
    accepted = json['Accepted'];
    placed = json['Placed'];
    sale =  json['sale']!=null ? json['sale'].toDouble(): 0;
    category = json['category'];
    product = json['product'];
    shopName = json['Shopname'];
    zonestatus = json['zonestatus'];
    zoneId = json['zone_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor'] = this.vendor;
    data['Shipped'] = this.shipped;
    data['Accepted'] = this.accepted;
    data['Placed'] = this.placed;
    data['sale'] = this.sale;
    data['category'] = this.category;
    data['product'] = this.product;
    data['shop_name'] = this.shopName;
    return data;
  }
}
