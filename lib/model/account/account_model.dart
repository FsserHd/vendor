

class AccountModel {
  bool? success;
  Data? data;
  String? message;

  AccountModel({this.success, this.data, this.message});

  AccountModel.fromJson(Map<String, dynamic> json) {
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
  BankDetails? bankDetails;
  String? opentime;
  String? closetime;

  Data({this.bankDetails,this.closetime,this.opentime});

  Data.fromJson(Map<String, dynamic> json) {
    bankDetails = json['bank_details'] != null
        ? new BankDetails.fromJson(json['bank_details'])
        : null;
    opentime = json['opentime'];
    closetime = json['closetime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.bankDetails != null) {
      data['bank_details'] = this.bankDetails!.toJson();
    }
    return data;
  }
}

class BankDetails {
  String? bankname;
  String? accountholder;
  String? accountnumber;
  String? ifsc;
  String? branch;
  String? upiid;

  BankDetails(
      {this.bankname,
        this.accountholder,
        this.accountnumber,
        this.ifsc,
        this.branch,
        this.upiid});

  BankDetails.fromJson(Map<String, dynamic> json) {
    bankname = json['bankname'];
    accountholder = json['accountholder'];
    accountnumber = json['accountnumber'];
    ifsc = json['ifsc'];
    branch = json['branch'];
    upiid = json['upiid'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['bankname'] = this.bankname;
    data['accountholder'] = this.accountholder;
    data['accountnumber'] = this.accountnumber;
    data['ifsc'] = this.ifsc;
    data['branch'] = this.branch;
    data['upiid'] = this.upiid;
    return data;
  }
}
