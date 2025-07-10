class ShopProfileModel {

  bool? success;
  Data? data;
  String? stats;

  ShopProfileModel({this.success, this.data, this.stats});

  ShopProfileModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new Data.fromJson(json['data']) : null;
    stats = json['stats'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    data['stats'] = this.stats;
    return data;
  }
}

class Data {
  String? vendorId;
  String? name;
  String? ratingNum;
  String? ratingTotal;
  String? email;
  String? favourite;
  String? fssaiNo;
  String? fssaiFile;
  String? password;
  String? company;
  String? discount;
  String? discountId;
  String? upTo;
  String? displayName;
  String? address1;
  String? status;
  String? createTimestamp;
  String? memberExpireTimestamp;
  String? phone;
  String? latitude;
  String? longitude;
  String? generalDetail;
  String? bankDetails;
  String? kycSeller;
  String? logo;
  String? subtitle;
  String? livestatus;
  String? token;
  String? type;
  String? driverAssign;
  String? autoAssign;
  String? focusId;
  String? profileComplete;
  String? instant;
  String? takeaway;
  String? schedule;
  String? plan;
  String? paymentType;
  String? paymentStatus;
  String? zoneId;
  String? handoverTime;
  String? bestSeller;

  Data(
      {this.vendorId,
        this.name,
        this.ratingNum,
        this.ratingTotal,
        this.email,

        this.favourite,
        this.fssaiNo,
        this.fssaiFile,
        this.password,
        this.company,
        this.discount,
        this.discountId,
        this.upTo,
        this.displayName,
        this.address1,
        this.status,
        this.createTimestamp,

        this.memberExpireTimestamp,

        this.phone,

        this.latitude,
        this.longitude,

        this.generalDetail,
        this.bankDetails,
        this.kycSeller,

        this.logo,
        this.subtitle,
        this.livestatus,

        this.token,

        this.type,
        this.driverAssign,
        this.autoAssign,
        this.focusId,
        this.profileComplete,

        this.instant,
        this.takeaway,
        this.schedule,
        this.plan,
        this.paymentType,
        this.paymentStatus,

        this.zoneId,
        this.handoverTime,
        this.bestSeller});

  Data.fromJson(Map<String, dynamic> json) {
    vendorId = json['vendor_id'];
    name = json['name'];
    ratingNum = json['rating_num'];
    ratingTotal = json['rating_total'];
    email = json['email'];

    favourite = json['favourite'];
    fssaiNo = json['fssai_no'];
    fssaiFile = json['fssai_file'];
    password = json['password'];
    company = json['company'];
    discount = json['discount'];
    discountId = json['discount_id'];
    upTo = json['upTo'];
    displayName = json['display_name'];
    address1 = json['address1'];
    status = json['status'];
    createTimestamp = json['create_timestamp'];

    memberExpireTimestamp = json['member_expire_timestamp'];

    phone = json['phone'];

    latitude = json['latitude'];
    longitude = json['longitude'];

    generalDetail = json['general_detail'];
    bankDetails = json['bank_details'];
    kycSeller = json['kyc_seller'];

    logo = json['logo'];
    subtitle = json['subtitle'];
    livestatus = json['livestatus'];

    token = json['token'];

    type = json['type'];
    driverAssign = json['driver_assign'];
    autoAssign = json['auto_assign'];
    focusId = json['focus_id'];
    profileComplete = json['profile_complete'];

    instant = json['instant'];
    takeaway = json['takeaway'];
    schedule = json['schedule'];
    plan = json['plan'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];

    zoneId = json['zone_id'];
    handoverTime = json['handover_time'];
    bestSeller = json['best_seller'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['vendor_id'] = this.vendorId;
    data['name'] = this.name;
    data['rating_num'] = this.ratingNum;
    data['rating_total'] = this.ratingTotal;
    data['email'] = this.email;

    data['favourite'] = this.favourite;
    data['fssai_no'] = this.fssaiNo;
    data['fssai_file'] = this.fssaiFile;
    data['password'] = this.password;
    data['company'] = this.company;
    data['discount'] = this.discount;
    data['discount_id'] = this.discountId;
    data['upTo'] = this.upTo;
    data['display_name'] = this.displayName;
    data['address1'] = this.address1;
    data['status'] = this.status;
    data['create_timestamp'] = this.createTimestamp;

    data['member_expire_timestamp'] = this.memberExpireTimestamp;

    data['phone'] = this.phone;

    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    data['general_detail'] = this.generalDetail;
    data['bank_details'] = this.bankDetails;
    data['kyc_seller'] = this.kycSeller;

    data['logo'] = this.logo;
    data['subtitle'] = this.subtitle;
    data['livestatus'] = this.livestatus;

    data['token'] = this.token;

    data['type'] = this.type;
    data['driver_assign'] = this.driverAssign;
    data['auto_assign'] = this.autoAssign;
    data['focus_id'] = this.focusId;
    data['profile_complete'] = this.profileComplete;

    data['instant'] = this.instant;
    data['takeaway'] = this.takeaway;
    data['schedule'] = this.schedule;
    data['plan'] = this.plan;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;

    data['zone_id'] = this.zoneId;
    data['handover_time'] = this.handoverTime;
    data['best_seller'] = this.bestSeller;
    return data;
  }
}
