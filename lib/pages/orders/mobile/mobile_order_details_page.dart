


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
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

class MobileOrderDetailsPage extends StatefulWidget {
  Data dataBean;
  MobileOrderDetailsPage(this.dataBean, {super.key});

  @override
  _MobileOrderDetailsPageState createState() => _MobileOrderDetailsPageState();
}

class _MobileOrderDetailsPageState extends StateMVC<MobileOrderDetailsPage> {

  late HomeController _con;

  _MobileOrderDetailsPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  var total = 0.0;
  var commission = 0.0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    total = (widget.dataBean.paymentDetails!.subTotal! + widget.dataBean.paymentDetails!.tax!+widget.dataBean.paymentDetails!.packingCharge!) - widget.dataBean.paymentDetails!.vendorDiscount!;
    if(widget.dataBean.deliveryAssigned!=null) {
      _con.getDriverDetails(context, widget.dataBean.deliveryAssigned!);
    }
    widget.dataBean.productDetails!.forEach((element) {
      commission += (double.parse(element.price!)  - double.parse(element.strike!))* element.qty!;
    });
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
        title: Text(S.of(context, 'order_details'),style: TextStyle(color: Colors.white,fontFamily: AppStyle.robotoRegular),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Invoice",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                          Text("OrderID #${widget.dataBean.saleCode}",style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                          Text(TimeUtils.getTimeStampToDate(int.parse(widget.dataBean.paymentTimestamp!)),style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Order Summary",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  children: [
                                    ListView.builder(
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: widget.dataBean.productDetails!.length,
                                        shrinkWrap: true,
                                        itemBuilder: (context, dindex) {
                                          var productSet = widget.dataBean.productDetails![dindex];
                                      return Padding(
                                        padding: const EdgeInsets.only(top: 5),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    // Image.asset("assets/images/non_veg.png",height: 20,),
                                                    // SizedBox(width: 4,),
                                                    Image.network(productSet.image!,height: 50,width: 50, fit: BoxFit.fill,),
                                                    SizedBox(width: 4,),
                                                    Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Row(
                                                          children: [
                                                            Text(
                                                              "${productSet.qty}x",
                                                              style: AppStyle.font14MediumBlack87.override(
                                                                  color: Colors.black,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                            SizedBox(width: 2,),
                                                            Text(
                                                              productSet.productName!,
                                                              style: AppStyle.font14MediumBlack87.override(
                                                                  color: Colors.black,
                                                                  fontSize: 12,
                                                                  fontWeight: FontWeight.bold),
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                                Text(
                                                  ApiConstants.currency+productSet.price!,
                                                  style: AppStyle.font22BoldWhite
                                                      .override(color: Colors.green, fontSize: 14),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                  ],
                                ),
                              ),

                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              if(widget.dataBean.description!.isNotEmpty && widget.dataBean.description!=null)
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
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
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Instruction",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                            Text(widget.dataBean.description!,style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              if(widget.dataBean.description!=null)
                SizedBox(height: 10,),
              if(widget.dataBean.addonDetails!=null && widget.dataBean.addonDetails!.isNotEmpty)
              SizedBox(height: 10,),
              if(widget.dataBean.addonDetails!=null && widget.dataBean.addonDetails!.isNotEmpty)
              Text("Add On Details",style: TextStyle(color: Colors.black,fontFamily: AppStyle.robotoBold,fontSize: 16),),
              if(widget.dataBean.addonDetails!=null && widget.dataBean.addonDetails!.isNotEmpty)
              SizedBox(height: 10,),
              if(widget.dataBean.addonDetails!=null && widget.dataBean.addonDetails!.isNotEmpty)
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white, // Background color
                  borderRadius: BorderRadius.circular(15.0), // Rounded corners
                  border: Border.all(
                    color: Colors.grey.shade300, // Light gray border color
                    width: 2.0, // Border width
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListView.builder(
                      itemCount: widget.dataBean.addonDetails!.length,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context,pIndex){
                        var productBean =widget.dataBean.addonDetails![pIndex];
                        return Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  // Image.asset("assets/images/non_veg.png",height: 12,width: 12,),
                                  // SizedBox(width: 5,),
                                  Row(
                                    children: [
                                      Text(productBean.qty.toString()+"x",style  : AppStyle.font14MediumBlack87.override(fontSize: 13,color: Colors.grey),),
                                      SizedBox(width: 2,),
                                      Text(productBean.name!,style  : AppStyle.font14MediumBlack87.override(fontSize: 13),),
                                    ],
                                  ),
                                ],
                              ),
                              Text(
                                ApiConstants.currency+productBean.price!,
                                style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.grey),
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Billing",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                          Text(widget.dataBean.vendorDetails!.pickupAddress!,style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                          Text(widget.dataBean.vendorDetails!.mobile!,style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Shipping To",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                          Text(widget.dataBean.shippingAddress!.addressSelect!,style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                          Text(widget.dataBean.shippingAddress!.phone!,style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                          SizedBox(height: 10,),
                          Row(
                            children: [
                              InkWell(
                                  child: Icon(Icons.call),onTap: (){
                                    PageNavigation.gotoDialPage(context, widget.dataBean.shippingAddress!.phone!);
                              },),
                              SizedBox(width: 30,),
                              InkWell(
                                  onTap: (){
                                    PageNavigation.gotoChatPage(context,widget.dataBean.saleCode!,"user","vendor");
                                  },
                                  child: Icon(Icons.message)),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Payment",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Sub Total",
                                style: AppStyle.font22BoldWhite.override(color: Colors.grey, fontSize: 14),
                              ),
                              Text(
                                ApiConstants.currency +
                                    (widget.dataBean.paymentDetails!.subTotal!.round() +
                                        (widget.dataBean.addonDetails?.fold(0, (sum, item) => sum! + (int.parse(item.price!) * item.qty!)) ?? 0)
                                    ).toString(),
                                style: AppStyle.font22BoldWhite.override(color: Colors.grey, fontSize: 14),
                              ),
                            ],
                          ),

                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Tax",style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                              Text(ApiConstants.currency+widget.dataBean.paymentDetails!.tax!.round().toString(),style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Packing Charges",style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                              Text(ApiConstants.currency+widget.dataBean.paymentDetails!.packingCharge!.round().toString(),style: AppStyle.font22BoldWhite.override(color: Colors.grey,fontSize: 14),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Shop Discount",style: AppStyle.font22BoldWhite.override(color: Colors.green,fontSize: 14),),
                              Text(ApiConstants.currency+widget.dataBean.paymentDetails!.vendorDiscount!.round().toString(),style: AppStyle.font22BoldWhite.override(color: Colors.green,fontSize: 14),),
                            ],
                          ),

                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Total",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                              Text(ApiConstants.currency+((total.round() + (widget.dataBean.addonDetails?.fold(0, (sum, item) => sum! + (int.parse(item.price!) * item.qty!)) ?? 0))).toString(),style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                            ],
                          ),
                          SizedBox(height: 5,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Commission",style: AppStyle.font22BoldWhite.override(color: Colors.brown,fontSize: 14),),
                              Text(ApiConstants.currency+(commission).round().toString().toString(),style: AppStyle.font22BoldWhite.override(color: Colors.brown,fontSize: 14),),
                            ],
                          ),
                          SizedBox(height: 10,),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text("Payout Amount",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                              Text(ApiConstants.currency+((total.round() + (widget.dataBean.addonDetails?.fold(0, (sum, item) => sum! + (int.parse(item.price!) * item.qty!)) ?? 0)) - commission).toString(),style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),
              widget.dataBean.status == "Accepted" ? _con.driverModel.data!=null  ? Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
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
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Driver Details",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                             Row(
                               children: [
                                 // Image.network(_con.driverModel.data!.image!,height: 60,width: 60,),
                                 // SizedBox(width: 10,),
                                 Column(
                                   crossAxisAlignment: CrossAxisAlignment.start,
                                   children: [
                                     Text(_con.driverModel.data!.name!,style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                                     Text(_con.driverModel.data!.phone!,style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 14),),
                                   ],
                                 )
                               ],
                             ),
                              Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: (){
                                        ValidationUtils.showAppToast("calling");
                                      },
                                        child: Icon(Icons.call)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                        onTap: (){
                                          ValidationUtils.showAppToast("chat");
                                        },
                                        child: Icon(Icons.chat)),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ):Container():Container(),
              SizedBox(height: 10,),
              widget.dataBean.status == "Accepted" && _con.driverModel.data!=null ? InkWell(
                onTap: () {
                    _con.onReady(context, widget.dataBean.saleCode!);
                },
                child: Container(
                  width: 120,
                  height: 40,
                  padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.green,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Center(
                    child: Text(
                      'On Ready',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ):Container(),
            ],
          ),
        ),
      ),
    );
  }
}
