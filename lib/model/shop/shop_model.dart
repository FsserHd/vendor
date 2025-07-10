
class ShopModel {
  bool? success;
  Data? data;
  String? message;

  ShopModel({this.success, this.data, this.message});

  ShopModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? shopName;
  String? email;
  String? apiToken;
  String? deviceToken;
  String? phone;
  String? status;
  bool? auth;
  String? image;
  String? coverImage;
  int? shopTypeId;
  int? focusID;
  int? type;
  String? focusName;
  String? colorCode;
  String? registerDate;
  bool? liveStatus;
  bool? autoAssign;
  bool? driverAllAccess;
  bool? profileStatus;
  String? profileComplete;
  String? expiredTime;
  String? address;
  String? zoneId;
  String? supportMobile;
  String? supportWhatsapp;
  String? zoneName;

  Data(
      {this.id,
        this.name,
        this.shopName,
        this.email,
        this.apiToken,
        this.deviceToken,
        this.phone,
        this.status,
        this.auth,
        this.image,
        this.coverImage,
        this.shopTypeId,
        this.focusID,
        this.focusName,
        this.colorCode,
        this.registerDate,
        this.liveStatus,
        this.autoAssign,
        this.driverAllAccess,
        this.profileStatus,
        this.profileComplete,
        this.expiredTime,
        this.address,
        this.zoneId,
        this.supportMobile,
        this.supportWhatsapp,
        this.zoneName,this.type});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    shopName = json['shopName'];
    email = json['email'];
    apiToken = json['api_token'];
    deviceToken = json['device_token'];
    phone = json['phone'];
    status = json['status'];
    auth = json['auth'];
    image = json['image'];
    coverImage = json['coverImage'];
    shopTypeId = json['shopTypeId'];
    focusID = json['focusID'];
    focusName = json['focusName'];
    colorCode = json['colorCode'];
    registerDate = json['registerDate'];
    liveStatus = json['liveStatus'];
    autoAssign = json['autoAssign'];
    driverAllAccess = json['driverAllAccess'];
    profileStatus = json['profileStatus'];
    profileComplete = json['profileComplete'];
    expiredTime = json['expiredTime'];
    address = json['address'];
    zoneId = json['zoneId'];
    supportMobile = json['support_mobile'];
    supportWhatsapp = json['support_whatsapp'];
    zoneName = json['zoneName'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['shopName'] = this.shopName;
    data['email'] = this.email;
    data['api_token'] = this.apiToken;
    data['device_token'] = this.deviceToken;
    data['phone'] = this.phone;
    data['status'] = this.status;
    data['auth'] = this.auth;
    data['image'] = this.image;
    data['coverImage'] = this.coverImage;
    data['shopTypeId'] = this.shopTypeId;
    data['focusID'] = this.focusID;
    data['focusName'] = this.focusName;
    data['colorCode'] = this.colorCode;
    data['registerDate'] = this.registerDate;
    data['liveStatus'] = this.liveStatus;
    data['autoAssign'] = this.autoAssign;
    data['driverAllAccess'] = this.driverAllAccess;
    data['profileStatus'] = this.profileStatus;
    data['profileComplete'] = this.profileComplete;
    data['expiredTime'] = this.expiredTime;
    data['address'] = this.address;
    data['zoneId'] = this.zoneId;
    data['support_mobile'] = this.supportMobile;
    data['support_whatsapp'] = this.supportWhatsapp;
    data['zoneName'] = this.zoneName;
    return data;
  }
}
