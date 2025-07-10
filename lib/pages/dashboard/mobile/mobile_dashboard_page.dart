

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/constants/api_constants.dart';
import 'package:vendor/constants/app_colors.dart';
import 'package:vendor/constants/app_style.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';
import 'package:vendor/navigation/page_navigation.dart';
import 'package:vendor/pages/home/mobile/mobile_home_page.dart';
import 'package:vendor/pages/orders/mobile/dashboard_order_page.dart';
import 'package:vendor/utils/preference_utils.dart';

import '../../../constants/lang.dart';
import '../../../controller/home_controller.dart';

class MobileDashboardPage extends StatefulWidget {
  const MobileDashboardPage({super.key});

  @override
  _MobileDashboardPageState createState() => _MobileDashboardPageState();
}

class _MobileDashboardPageState extends StateMVC<MobileDashboardPage> with SingleTickerProviderStateMixin, WidgetsBindingObserver {
  final GlobalKey<MobileHomePageState> _homePageKey = GlobalKey<MobileHomePageState>();
  late HomeController _con;

  _MobileDashboardPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  late AnimationController _controller;
  late Animation<double> _animation;
  String vendorType = "2";
  MobileHomePage mobileHomePage = MobileHomePage();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _con.getDashboard(context);
    _controller = AnimationController(
      duration: const Duration(seconds: 3), // Set the duration of the animation
      vsync: this,
    )..repeat(); // Repeat the animation indefinitely

    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
    PreferenceUtils.getVendorType().then((value){
      setState(() {
        vendorType = value!;
      });
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      _con.getDashboard(context);
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _con.getDashboard(context);
    }
  }

  updatePage(BuildContext context){
    print("page reload");
    _con.getDashboard(context);
  }

  Future<void> _pullRefresh() async {
    print("page reload");
    _con.getDashboard(context);
  }

  void _launchURL() async {
    String _url='upi://pay?pa=dinesh@dlanzer&pn=Dinesh&am=1&tn=Test Payment&cu=INR';
    var result = await launch(_url);
    debugPrint(result.toString());
    if (result ==true) {
      print("Done");
    } else if (result ==false){
      print("Fail");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBgColor,
      body: Stack(
        children: [
          Positioned(right: 1,child: AnimatedBuilder(
            animation: _animation,
            child: Image.asset("assets/images/food.png"),
            builder: (context, child) {
              return Transform.rotate(
                angle: _animation.value * 2.0 * 3.141592653589793,
                child: child,
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RefreshIndicator(
              onRefresh: () async{
                _pullRefresh();
              },
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text("${S.of(context, "welcome")}",style: AppStyle.font22BoldWhite.override(color: Colors.black),),
                                      Text("${_con.dashboardModel.shopName ?? ""}",
                                        style: AppStyle.font22BoldWhite.override(color: Colors.black),maxLines: 2, overflow: TextOverflow.ellipsis,),
                                    ],
                                  ),
                                ),
                                InkWell(
                                    onTap: (){
                                      _pullRefresh();
                                    },
                                    child: Icon(Icons.refresh,color: Colors.black87,)),
                                SizedBox(width: 10,),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        //_launchURL();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  DashboardOrderPage("Placed"),
                          ),
                        ).then((value){
                          _con.getDashboard(context);
                        });
                      },
                      child: Container(
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/neworder.png"),
                                      SizedBox(width: 10,),
                                      Text(S.of(context, "new_orders"),style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text("${S.of(context, "orders")} ${_con.dashboardModel.placed ?? ""}",style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  DashboardOrderPage("Accepted"),
                          ),
                        ).then((value){
                          _con.getDashboard(context);
                        });
                      },
                      child: Container(
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/processing.png"),
                                      SizedBox(width: 10,),
                                      Text(S.of(context, "processing"),style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text("${S.of(context, "orders")} ${_con.dashboardModel.accepted ?? ""}",style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    InkWell(
                      onTap: (){
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>  DashboardOrderPage("Completed"),
                          ),
                        ).then((value){
                          _con.getDashboard(context);
                        });
                      },
                      child: Container(
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
                          padding: const EdgeInsets.all(10.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Image.asset("assets/images/completed.png"),
                                      SizedBox(width: 10,),
                                      Text(S.of(context, "completed"),style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                                    ],
                                  ),
                                  SizedBox(height: 10,),
                                  Text("${S.of(context, "orders")} ${_con.dashboardModel.shipped ?? ""}",style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(0.0),topRight: Radius.circular(20.0),bottomLeft: Radius.circular(0.0),bottomRight: Radius.circular(0.0)), // Adjust the radius as needed
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                vendorType == "2" ?Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text(S.of(context, "menu"),style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                          Text(" ${_con.dashboardModel.category ?? ""}",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      children: [
                                        Text(S.of(context, "items"),style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                        Text(" ${_con.dashboardModel.product ?? ""}",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                      ],
                                    ),
                                  ],
                                ):
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          Text("Category",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                          Text(" ${_con.dashboardModel.category ?? ""}",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      children: [
                                        Text("Sub Category",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                        Text(" ${_con.dashboardModel.product ?? ""}",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                      ],
                                    ),
                                    SizedBox(width: 20,),
                                    Column(
                                      children: [
                                        Text("Products",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                        Text(" ${_con.dashboardModel.product ?? ""}",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 12),),
                                      ],
                                    ),
                                  ],
                                ),
                                Column(
                                  children: [
                                    Text(S.of(context, "total_sale"),style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 16),),
                                    _con.dashboardModel.sale!=null ?    Text(" ${ApiConstants.currency}${_con.dashboardModel.sale!.round().toString() ?? "0"}",style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 16),):Container()
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
