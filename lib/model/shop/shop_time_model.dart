
class ShopTimeModel {
  String? opentime;
  String? closetime;

  ShopTimeModel({this.opentime, this.closetime});

  ShopTimeModel.fromJson(Map<String, dynamic> json) {
    opentime = json['opentime'];
    closetime = json['closetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['opentime'] = this.opentime;
    data['closetime'] = this.closetime;
    return data;
  }
}
