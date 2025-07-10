class OrderModel {
  bool? success;
  List<Data>? data;
  String? message;

  OrderModel({this.success, this.data, this.message});

  OrderModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(new Data.fromJson(v));
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

class Data {
  String? saleId;
  String? saleCode;
  String? buyer;
  String? shipping;
  String? paymentType;
  String? paymentStatus;
  String? paymentTimestamp;
  String? grandTotal;
  String? discount;
  String? description;
  String? saleDatetime;
  String? delivaryDatetime;
  String? viewed;
  String? deliveryAssigned;
  String? deliveryState;
  String? deliverAssignedtime;
  String? status;
  String? otp;
  String? deliverySlot;
  String? vendor;
  String? driverCharge;
  String? orderType;
  String? focusId;
  String? settlement;
  String? transcationid;

  String? rating;
  String? driverRating;
  String? zoneId;
  String? updateAssigntime;
  String? cancelReason;
  String? cookingTime;
  String? cookingMinutes;
  List<ProductDetails>? productDetails;
  List<Addon>? addonDetails;
  ShippingAddress? shippingAddress;
  PaymentDetails? paymentDetails;
  DeliveryStatus? deliveryStatus;
  VendorDetails? vendorDetails;
  Duration remainingTime = Duration();
  bool isCooking = false;

  Data(
      {this.saleId,
        this.saleCode,
        this.buyer,
        this.shipping,
        this.paymentType,
        this.paymentStatus,
        this.paymentTimestamp,
        this.grandTotal,
        this.discount,
        this.description,
        this.saleDatetime,
        this.delivaryDatetime,
        this.viewed,
        this.deliveryAssigned,
        this.deliveryState,
        this.deliverAssignedtime,
        this.status,
        this.otp,
        this.deliverySlot,
        this.vendor,
        this.driverCharge,
        this.orderType,
        this.focusId,
        this.rating,
        this.driverRating,
        this.zoneId,
        this.updateAssigntime,
        this.cancelReason,
        this.productDetails,
        this.shippingAddress,
        this.paymentDetails,
        this.deliveryStatus,this.vendorDetails,this.cookingTime,this.cookingMinutes,this.settlement,this.addonDetails,this.transcationid});

  Data.fromJson(Map<String, dynamic> json) {
    saleId = json['sale_id'];
    saleCode = json['sale_code'];
    buyer = json['buyer'];
    shipping = json['shipping'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    paymentTimestamp = json['payment_timestamp'];
    grandTotal = json['grand_total'];
    discount = json['discount'];
    description = json['description'];
    saleDatetime = json['sale_datetime'];
    delivaryDatetime = json['delivary_datetime'];
    viewed = json['viewed'];
    deliveryAssigned = json['delivery_assigned'];
    deliveryState = json['delivery_state'];
    deliverAssignedtime = json['deliver_assignedtime'];
    status = json['status'];
    otp = json['otp'];
    deliverySlot = json['delivery_slot'];
    vendor = json['vendor'];
    driverCharge = json['driver_charge'];
    orderType = json['order_type'];
    focusId = json['focus_id'];
    transcationid = json['transcationid'];

    rating = json['rating'];
    driverRating = json['driver_rating'];
    zoneId = json['zone_id'];
    updateAssigntime = json['update_assigntime'];
    cookingTime = json['cooking_time'];
    cookingMinutes = json['cooking_minutes'];
    cancelReason = json['cancel_reason'];
    settlement = json['settlement'];
    if (json['product_details'] != null) {
      productDetails = <ProductDetails>[];
      json['product_details'].forEach((v) {
        productDetails!.add(new ProductDetails.fromJson(v));
      });
    }
    if (json['addon_details'] != null) {
      addonDetails = <Addon>[];
      json['addon_details'].forEach((v) {
        addonDetails!.add(new Addon.fromJson(v));
      });
    }
    shippingAddress = json['shipping_address'] != null
        ? new ShippingAddress.fromJson(json['shipping_address'])
        : null;
    paymentDetails = json['payment_details'] != null
        ? new PaymentDetails.fromJson(json['payment_details'])
        : null;
    deliveryStatus = json['delivery_status'] != null
        ? new DeliveryStatus.fromJson(json['delivery_status'])
        : null;
    vendorDetails = json['vendor_details'] != null
        ? new VendorDetails.fromJson(json['vendor_details'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['sale_id'] = this.saleId;
    data['sale_code'] = this.saleCode;
    data['buyer'] = this.buyer;
    data['shipping'] = this.shipping;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['payment_timestamp'] = this.paymentTimestamp;
    data['grand_total'] = this.grandTotal;
    data['discount'] = this.discount;
    data['description'] = this.description;
    data['sale_datetime'] = this.saleDatetime;
    data['delivary_datetime'] = this.delivaryDatetime;
    data['viewed'] = this.viewed;
    data['delivery_assigned'] = this.deliveryAssigned;
    data['delivery_state'] = this.deliveryState;
    data['deliver_assignedtime'] = this.deliverAssignedtime;
    data['status'] = this.status;
    data['otp'] = this.otp;
    data['delivery_slot'] = this.deliverySlot;
    data['vendor'] = this.vendor;
    data['driver_charge'] = this.driverCharge;
    data['order_type'] = this.orderType;
    data['focus_id'] = this.focusId;
    data['rating'] = this.rating;
    data['driver_rating'] = this.driverRating;
    data['zone_id'] = this.zoneId;
    data['update_assigntime'] = this.updateAssigntime;
    data['cancel_reason'] = this.cancelReason;
    if (this.productDetails != null) {
      data['product_details'] =
          this.productDetails!.map((v) => v.toJson()).toList();
    }
    if (this.shippingAddress != null) {
      data['shipping_address'] = this.shippingAddress!.toJson();
    }
    if (this.paymentDetails != null) {
      data['payment_details'] = this.paymentDetails!.toJson();
    }
    if (this.deliveryStatus != null) {
      data['delivery_status'] = this.deliveryStatus!.toJson();
    }
    return data;
  }
}

class ProductDetails {
  String? id;
  String? productName;
  String? price;
  String? strike;
  int? offer;
  String? quantity;
  int? qty;
  String? variant;
  String? variantValue;
  String? userId;

  String? unit;

  String? image;
  double? tax;
  String? discount;
  int? packingCharge;


  ProductDetails(
      {this.id,
        this.productName,
        this.price,
        this.strike,
        this.offer,
        this.quantity,
        this.qty,
        this.variant,
        this.variantValue,
        this.userId,

        this.unit,

        this.image,
        this.tax,
        this.discount,
        this.packingCharge,
        });

  ProductDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    productName = json['product_name'];
    price = json['price'];
    strike = json['strike'];
    offer = json['offer'];
    quantity = json['quantity'];
    qty = json['qty'];
    variant = json['variant'];
    variantValue = json['variantValue'];
    userId = json['userId'];

    unit = json['unit'];

    image = json['image'];
    tax = parseGrandTotal(json['tax']);
    discount = json['discount'];
    packingCharge = json['packingCharge'];

  }
  double? parseGrandTotal(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['product_name'] = this.productName;
    data['price'] = this.price;
    data['strike'] = this.strike;
    data['offer'] = this.offer;
    data['quantity'] = this.quantity;
    data['qty'] = this.qty;
    data['variant'] = this.variant;
    data['variantValue'] = this.variantValue;
    data['userId'] = this.userId;

    data['unit'] = this.unit;

    data['image'] = this.image;
    data['tax'] = this.tax;
    data['discount'] = this.discount;
    data['packingCharge'] = this.packingCharge;
    return data;
  }
}

class ShippingAddress {

  String? addressSelect;
  double? latitude;
  double? longitude;

  String? username;
  String? phone;
  String? userId;

  ShippingAddress(
      {
        this.addressSelect,
        this.latitude,
        this.longitude,

        this.username,
        this.phone,
        this.userId});

  ShippingAddress.fromJson(Map<String, dynamic> json) {

    addressSelect = json['addressSelect'];
    latitude = json['latitude'];
    longitude = json['longitude'];

    username = json['username'];
    phone = json['phone'];
    userId = json['userId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['addressSelect'] = this.addressSelect;
    data['latitude'] = this.latitude;
    data['longitude'] = this.longitude;

    data['username'] = this.username;
    data['phone'] = this.phone;
    data['userId'] = this.userId;
    return data;
  }
}

class PaymentDetails {

  String? paymentType;
  String? method;
  double? grandTotal;
  double? subTotal;
  String? discount;
  double? vendorDiscount;
  String? km;
  int? deliveryFees;
  int? deliveryTips;
  double? tax;
  double? packingCharge;

  PaymentDetails(
      {
        this.paymentType,
        this.method,
        this.grandTotal,
        this.subTotal,
        this.discount,
        this.km,
        this.deliveryFees,
        this.deliveryTips,
        this.tax,
        this.packingCharge,this.vendorDiscount});

  PaymentDetails.fromJson(Map<String, dynamic> json) {

    paymentType = json['paymentType'];
    method = json['method'];
    grandTotal = parseGrandTotal(json['grand_total']);
    subTotal = parseGrandTotal(json['sub_total']);
    vendorDiscount = json['vendorDiscount'] == 0 ? 0 : json['vendorDiscount'].toDouble();
    discount = json['discount'].toString();
    km = json['km'];
    deliveryFees = json['delivery_fees'];
    deliveryTips = json['delivery_tips'];
    tax = parseGrandTotal(json['tax']);
    packingCharge = parseGrandTotal(json['packingCharge']);
  }

  double? parseGrandTotal(dynamic value) {
    if (value is int) {
      return value.toDouble();
    } else if (value is double) {
      return value;
    } else {
      return null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['paymentType'] = this.paymentType;
    data['method'] = this.method;
    data['grand_total'] = this.grandTotal;
    data['sub_total'] = this.subTotal;
    data['discount'] = this.discount;
    data['km'] = this.km;
    data['delivery_fees'] = this.deliveryFees;
    data['delivery_tips'] = this.deliveryTips;
    data['tax'] = this.tax;
    data['packingCharge'] = this.packingCharge;
    return data;
  }
}

class VendorDetails {

  String? pickupAddress;
  String? mobile;

  VendorDetails(
      {
        this.pickupAddress,
        this.mobile});

  VendorDetails.fromJson(Map<String, dynamic> json) {

    pickupAddress = json['pickupAddress'];
    mobile = json['mobile'];

  }


}

class DeliveryStatus {
  String? admin;
  bool? placedstatus;
  int? placedtime;
  bool? acceptstatus;
  int? accepttime;
  bool? packedstatus;
  int? packedtime;
  bool? shippedstatus;
  int? shippedtime;
  bool? deliverstatus;
  int? delivered;

  DeliveryStatus(
      {this.admin,
        this.placedstatus,
        this.placedtime,
        this.acceptstatus,
        this.accepttime,
        this.packedstatus,
        this.packedtime,
        this.shippedstatus,
        this.shippedtime,
        this.deliverstatus,
        this.delivered});

  DeliveryStatus.fromJson(Map<String, dynamic> json) {
    admin = json['admin'];
    placedstatus = json['placedstatus'];
    placedtime = json['placedtime'];
    acceptstatus = json['acceptstatus'];
    accepttime = json['accepttime'];
    packedstatus = json['packedstatus'];
    packedtime = json['packedtime'];
    shippedstatus = json['shippedstatus'];
    shippedtime = json['shippedtime'];
    deliverstatus = json['deliverstatus'];
    delivered = json['delivered'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['admin'] = this.admin;
    data['placedstatus'] = this.placedstatus;
    data['placedtime'] = this.placedtime;
    data['acceptstatus'] = this.acceptstatus;
    data['accepttime'] = this.accepttime;
    data['packedstatus'] = this.packedstatus;
    data['packedtime'] = this.packedtime;
    data['shippedstatus'] = this.shippedstatus;
    data['shippedtime'] = this.shippedtime;
    data['deliverstatus'] = this.deliverstatus;
    data['delivered'] = this.delivered;
    return data;
  }
}
class Addon {
  String? addonId;
  String? productId;
  String? name;
  String? price;
  String? type;
  int? qty = 0;
  bool? selected;
  String? foodType;

  Addon(
      {this.addonId,
        this.productId,
        this.name,
        this.price,
        this.type,
        this.selected,
        this.foodType});

  Addon.fromJson(Map<String, dynamic> json) {
    addonId = json['addon_id'];
    productId = json['product_id'];
    name = json['name'];
    price = json['price'];
    type = json['type'];
    selected = json['selected'];
    foodType = json['foodType'];
    qty = json['qty'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['addon_id'] = this.addonId;
    data['product_id'] = this.productId;
    data['name'] = this.name;
    data['price'] = this.price;
    data['qty'] = this.qty;
    data['type'] = this.type;
    data['selected'] = this.selected;
    data['foodType'] = this.foodType;
    return data;
  }
}
