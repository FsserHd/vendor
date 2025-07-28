import 'dart:async';
import 'dart:io';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/constants/api_constants.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';
import 'package:vendor/model/order/order_model.dart';
import 'package:vendor/navigation/page_navigation.dart';
import 'package:vendor/utils/time_utils.dart';
import 'package:vendor/utils/validation_utils.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_style.dart';
import '../../../constants/lang.dart';
import '../../../controller/home_controller.dart';
import '../../../utils/preference_utils.dart';
import 'mobile_order_details_page.dart';

class DashboardOrderPage extends StatefulWidget {
  String type;
  DashboardOrderPage(this.type, {super.key});

  @override
  _DashboardOrderPageState createState() => _DashboardOrderPageState();
}

class _DashboardOrderPageState extends StateMVC<DashboardOrderPage> with WidgetsBindingObserver{

  late HomeController con;

  _DashboardOrderPageState() : super(HomeController()) {
    con = controller as HomeController;
  }

  String _selectedItem = 'All Orders';
  DateTime? cookingEndTime;
  late Timer _timer;
  String? vendorType = "";

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addObserver(this);
    super.initState();
    con.getOrders(context,widget.type);
    PreferenceUtils.getVendorType().then((value) {
      setState(() {
        vendorType = value;
      });
    });
    if(!kIsWeb) {
      FirebaseMessaging.onMessage.listen((RemoteMessage message) {
        con.getOrders(context, "all");
      });
    }
  }


  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print("hello");
  }


  void _startTimer(DateTime cookingEndTime, Data dataBean) {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        dataBean.remainingTime = cookingEndTime.difference(DateTime.now());
        dataBean.isCooking = true;
        if (dataBean.remainingTime.isNegative) {
          timer.cancel();
          dataBean.isCooking = false;
        }
      });

    });
  }

  String formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String twoDigitMinutes = twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));
    return "${twoDigits(duration.inHours)}:$twoDigitMinutes:$twoDigitSeconds";
  }

  void _showCustomDialog(BuildContext context, String saleCode, Data dataBean) {
    var minController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  vendorType == "2"  ? Text(
                    'Cooking Time',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ):Text(
                    'Delivery Time',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 60,
                    child: TextField(
                      controller: minController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Mins',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      if(ValidationUtils.emptyValidation(minController.text)) {
                        con.setCookingTime(
                            context, saleCode, minController.text,_selectedItem);
                        Navigator.pop(context);
                      }else{
                        vendorType == "2" ? ValidationUtils.showAppToast("Enter Cooking time"):
                        ValidationUtils.showAppToast("Enter Delivery Time");
                      }
                    },
                    child: Container(
                      width: 90,
                      padding: EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                        Colors.blue, // Red background color
                        borderRadius: BorderRadius.circular(
                            5), // Rounded corners
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color:
                            Colors.white, // White text color
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Orders",style: TextStyle(color: Colors.white,fontFamily: AppStyle.robotoRegular),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white, // Light gray background color
                  borderRadius: BorderRadius.circular(10), // Rounded corners
                  border: Border.all(color: Colors.grey.shade300), // Border color
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    value: _selectedItem,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    onChanged: (String? newValue) {
                      setState(() {
                        _selectedItem = newValue!;
                        if(newValue == "All Orders") {
                          con.getOrders(context, "all");
                        }else if(newValue == "New Orders"){
                          con.getOrders(context, "Placed");
                        }else if(newValue == "Processing"){
                          con.getOrders(context, "Accepted");
                        }else if(newValue == "Completed"){
                          con.getOrders(context, "Completed");
                        }
                      });
                    },
                    items: <String>[
                      'All Orders',
                      'New Orders',
                      'Processing',
                      "Completed"
                    ].map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          child: Text(value),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              con.orderModel.data != null
                  ? ListView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: con.orderModel.data!.length,
                  itemBuilder: (context, index) {
                    var dataBean = con.orderModel.data![index];
                    var addTotal = dataBean.addonDetails?.fold(0, (sum, item) => sum! + (int.parse(item.price!) * item.qty!)) ?? 0;
                    var totalAmount = (dataBean.paymentDetails!.subTotal! +dataBean.paymentDetails!.tax! + dataBean.paymentDetails!.packingCharge! + addTotal) - dataBean.paymentDetails!.vendorDiscount!;
                    if(dataBean.cookingTime!=null && dataBean.cookingTime!.isNotEmpty) {
                      cookingEndTime = DateTime.parse(dataBean.cookingTime!);
                      _startTimer(cookingEndTime!,dataBean);
                    }
                    return Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          // Adjust the radius as needed
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 10,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  dataBean.status == "Placed" ? Image.asset(
                                    "assets/images/waiting.png",
                                    height: 18,
                                  ) : dataBean.status == "Accepted" ? Image.asset(
                                    "assets/images/prepared.png",
                                    height: 18,
                                  ) : dataBean.status == "Cancelled" ? Image.asset(
                                    "assets/images/cancelled.png",
                                    height: 18,
                                  ):Image.asset(
                                    "assets/images/order_completed.png",
                                    height: 18,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${TimeUtils.getTimeStampToDate(int.parse(dataBean.paymentTimestamp!))}",
                                        style: AppStyle.font14MediumBlack87
                                            .override(
                                            color: Colors.black,
                                            fontSize: 12),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "ID:${dataBean.saleCode}",
                                            style: AppStyle.font14MediumBlack87
                                                .override(
                                                color: Colors.black,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          dataBean.status=="Completed" || dataBean.status=="Cancelled"  ? Container() :  dataBean.cookingTime!=null && dataBean.cookingTime!.isNotEmpty && dataBean.isCooking? Text(
                                            'E.Time: ${formatDuration(dataBean.remainingTime)}',
                                            style: TextStyle(fontSize: 12, color: Colors.red),
                                          ):Container(),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        ListView.builder(
                                            physics:
                                            const NeverScrollableScrollPhysics(),
                                            itemCount: dataBean.productDetails!.length,
                                            shrinkWrap: true,
                                            itemBuilder: (context, dindex) {
                                              var productBean  = dataBean.productDetails![dindex];
                                              return Padding(
                                                padding:
                                                const EdgeInsets.only(
                                                    top: 5),
                                                child: Column(
                                                  children: [
                                                    Row(
                                                      children: [
                                                        // Image.asset(
                                                        //   "assets/images/non_veg.png",
                                                        //   height: 14,
                                                        // ),
                                                        // SizedBox(
                                                        //   width: 2,
                                                        // ),
                                                        Text(
                                                          "${productBean.qty}x",
                                                          style: AppStyle
                                                              .font14MediumBlack87
                                                              .override(
                                                              color: Colors
                                                                  .black,
                                                              fontSize:
                                                              12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                        SizedBox(
                                                          width: 2,
                                                        ),
                                                        Text(
                                                          productBean.productName!,
                                                          style: AppStyle
                                                              .font14MediumBlack87
                                                              .override(
                                                              color: Colors
                                                                  .black,
                                                              fontSize:
                                                              12,
                                                              fontWeight:
                                                              FontWeight
                                                                  .bold),
                                                        ),
                                                      ],
                                                    )
                                                  ],
                                                ),
                                              );
                                            }),
                                      ],
                                    ),
                                  ),
                                  Text(
                                    ApiConstants.currency+totalAmount.round().toString(),
                                    style: AppStyle.font22BoldWhite.override(
                                        color: Colors.green, fontSize: 22),
                                  )
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              dataBean.description!=null && dataBean.description!.isNotEmpty ?
                              Text(
                                "Instruction: ${dataBean.description!}",
                                style: AppStyle.font22BoldWhite.override(
                                    color: Colors.brown, fontSize: 12),
                              ):Text(
                                "Instruction: No inputs",
                                style: AppStyle.font22BoldWhite.override(
                                    color: Colors.brown, fontSize: 12),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors.blue,
                                        // Red background color
                                        borderRadius: BorderRadius.circular(
                                            5), // Rounded corners
                                      ),
                                      child: Text(
                                        'View Details',
                                        style: TextStyle(
                                          color: Colors
                                              .white, // White text color
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MobileOrderDetailsPage(dataBean),
                                        ),
                                      ).then((value) {
                                        con.getOrders(context,"all");
                                      });
                                    },
                                  ),
                                  dataBean.status == "Placed" ? InkWell(
                                    onTap: (){
                                      con.ordersStatusUpdate(context, dataBean.saleCode!, "Cancelled",_selectedItem,"on_cancel");
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      decoration: BoxDecoration(
                                        color:
                                        Colors.red, // Red background color
                                        borderRadius: BorderRadius.circular(
                                            5), // Rounded corners
                                      ),
                                      child: Text(
                                        'Cancel',
                                        style: TextStyle(
                                          color:
                                          Colors.white, // White text color
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ):Container(),
                                  dataBean.status == "Placed"  ? InkWell(
                                    onTap: (){
                                      // _con.ordersStatusUpdate(context, dataBean.saleCode!, "Accepted");
                                      _showCustomDialog(context,dataBean.saleCode!,dataBean);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 4, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: Colors
                                            .green, // Red background color
                                        borderRadius: BorderRadius.circular(
                                            5), // Rounded corners
                                      ),
                                      child: Text(
                                        'Accept',
                                        style: TextStyle(
                                          color:
                                          Colors.white, // White text color
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ):Container()
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),

                              dataBean.addonDetails!.isNotEmpty ? Text("${dataBean.addonDetails!.length} Addon founds",style: AppStyle.font14MediumBlack87.override(fontSize: 12),):Container(),
                            ],
                          ),
                        ),
                      ),
                    );
                  })
                  : Container(
                child: Center(
                  child: Column(
                    children: [
                      Text(
                        'No Records found',
                        style: TextStyle(
                          color:
                          Colors.black, // White text color
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
