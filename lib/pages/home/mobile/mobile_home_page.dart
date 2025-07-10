

import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:share_plus/share_plus.dart';
import 'package:vendor/constants/app_colors.dart';
import 'package:vendor/constants/app_style.dart';
import 'package:vendor/controller/home_controller.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';
import 'package:vendor/main.dart';
import 'package:vendor/model/firebase/firebase_order_response.dart';
import 'package:vendor/navigation/page_navigation.dart';
import 'package:vendor/pages/home/drawer_page.dart';
import 'package:vendor/pages/orders/mobile/mobile_order_page.dart';
import 'package:vendor/utils/preference_utils.dart';

import '../../../constants/lang.dart';

class MobileHomePage extends StatefulWidget {

  static final GlobalKey<MobileHomePageState> globalKey = GlobalKey<MobileHomePageState>();
  const MobileHomePage({super.key});

  @override
  MobileHomePageState createState() => MobileHomePageState();
}

class MobileHomePageState extends StateMVC<MobileHomePage> {



  late HomeController _con;
  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  int vendortype = 2;

  MobileHomePageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  String _currentPage = 'Home';
  String get currentPage =>  _currentPage;
  var firebaseOrderResponse = FirebaseOrderResponse();
  late final FirebaseMessaging _firebaseMessaging;


  void updatePage(String page) {
    print("HomePage"+page);
    setState(() {
      _currentPage = page;
      PreferenceUtils.saveCurrentPage(page);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getUserLiveStatus(context);
    PreferenceUtils.getVendorType().then((value){
       setState(() {
         vendortype = int.parse(value!);
       });
    });
    if(!kIsWeb){
      _firebaseMessaging = FirebaseMessaging.instance;
    getFCMToken();
      FirebaseMessaging.instance.requestPermission();
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      firebaseOrderResponse = FirebaseOrderResponse();
      ///firebaseOrderResponse.vendorId = message.data['vendor_id'];

      firebaseOrderResponse.type = message.data['type'];
      firebaseOrderResponse.orderid = message.data['orderid'];
         print(firebaseOrderResponse.orderid);
         if(firebaseOrderResponse.type !="order_message") {
           if (firebaseOrderResponse.type == "on_admin_cancel") {
             playSound();
             _showOrderCancel(context);
           } else if (firebaseOrderResponse.type == "on_user_cancel") {

           } else {
             _con.orderDetailsGetBySaleCode(
                 context, firebaseOrderResponse.orderid!,
                 firebaseOrderResponse);
           }
         }
    });
      FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
        firebaseOrderResponse = FirebaseOrderResponse.fromJson(json.decode(message.notification!.body!));
        print(firebaseOrderResponse.orderid);
        _con.orderDetailsGetBySaleCode(context,firebaseOrderResponse.orderid!,firebaseOrderResponse);
      });
    }
  }

  void _showOrderCancel(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Order is Cancelled",
                        textAlign: TextAlign.center,
                        style: AppStyle.font14MediumBlack87.override(fontSize: 16),
                      ),

                    ],
                  ),
                  SizedBox(height: 20,),

                  Image.asset("assets/images/order_cancelled.png",height: 80,width: 80,),
                  SizedBox(height: 10,),
                  Text(
                    "Order ID:#${firebaseOrderResponse.orderid}",
                    style: AppStyle.font14MediumBlack87.override(fontSize: 16),
                  ),
                  SizedBox(height: 20,),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void getFCMToken() async {
    String? token = await _firebaseMessaging.getToken();
    print('FCM Token: $token');
    _con.updateFcmToken(context, token!);
  }



  DateTime? lastPressed;

  @override
  Widget build(BuildContext context) {
    return WillPopScope.new(
      onWillPop: () async {
        final now = DateTime.now();
        final maxDuration = Duration(seconds: 2);

        if (lastPressed == null || now.difference(lastPressed!) > maxDuration) {
          lastPressed = now;
          final snackBar = SnackBar(content: Text('Press back again to exit'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
          return false;
        }
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(''),
          actions: [
            InkWell(
              onTap: (){
                Share.share('App Link: https://thee4square.com/');
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(Icons.share,color: Colors.black,),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Row(
                children: [
                  // InkWell(
                  //     child: Icon(Icons.message,color: Colors.grey,size: 28,),onTap: (){
                  //       PageNavigation.gotoCustomerChatPage(context);
                  // },),
                  SizedBox(width: 10,),
                  Switch.adaptive(
                    value: _con.isShopStatus,
                    onChanged: (newValue) async {
                      //print(newValue);
                      _con.updateLiveStatus(context,newValue);
                    },
                    activeColor: Colors.white,
                    activeTrackColor: Colors.black87,
                    inactiveTrackColor: Colors.black26,
                    inactiveThumbColor: FlutterFlowTheme.of(context).secondaryText,
                  )

                ],
              ),
            ),
          ],
        ),
        body: DrawerPage(currentPage),
        drawer: Drawer(
          backgroundColor: AppColors.themeColor,
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              Image.asset("assets/images/logo_white.png",height: 120,width: 120,),
              ListTile(
                leading: Icon(Icons.home,color: Colors.white,),
                title: Text(S.of(context, "home"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer

                  updatePage('Home'); // Update the current page
                },
              ),
              ListTile(
                leading: Icon(Icons.ac_unit,color: Colors.white,),
                title: Text(S.of(context, "orders"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Orders'); // Update thete the current page
                },
              ),
              ListTile(
                leading: Icon(Icons.chat,color: Colors.white,),
                title: Text(S.of(context, "chat"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Chat'); // Update thete the current page
                },
              ),
              ListTile(
                leading: Icon(Icons.support,color: Colors.white,),
                title: Text(S.of(context, "contact_us"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Contact'); // Update thete the current page
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.reviews,color: Colors.white,),
              //   title: Text(S.of(context, "reviews"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
              //   onTap: () {
              //     Navigator.pop(context); // Close the drawer
              //     updatePage('Reviews'); // Update thete the current page
              //   },
              // ),
              vendortype == 2 ?
              ListTile(
                leading: Icon(Icons.menu,color: Colors.white,),
                title: Text(S.of(context, "menu"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Menu'); // Update thete the current page
                },
              ):ListTile(
                leading: Icon(Icons.menu,color: Colors.white,),
                title: Text("Category",style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Category'); // Update thete the current page
                },
              ),
              vendortype == 3 ?
              ListTile(
                leading: Icon(Icons.menu,color: Colors.white,),
                title: Text("Sub Category",style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Sub Category'); // Update thete the current page
                },
              ):Container(),
              vendortype == 2 ?ListTile(
                leading: Icon(Icons.list_alt,color: Colors.white,),
                title: Text(S.of(context, "items"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Items'); // Update thete the current page
                },
              ):ListTile(
                leading: Icon(Icons.list_alt,color: Colors.white,),
                title: Text("Products",style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Products'); // Update thete the current page
                },
              ),
              ListTile(
                leading: Icon(Icons.list_alt,color: Colors.white,),
                title: Text(S.of(context, "discount"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Discounts'); // Update thete the current page
                },
              ),
              ListTile(
                leading: Icon(Icons.payment,color: Colors.white,),
                title: Text(S.of(context, "finance_payout"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Finance'); // Update thete the current page
                },
              ),
              ListTile(
                leading: Icon(Icons.account_balance,color: Colors.white,),
                title: Text('Account',style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  updatePage('Account'); // Update thete the current page
                },
              ),
              // ListTile(
              //   leading: Icon(Icons.person,color: Colors.white,),
              //   title: Text(S.of(context, "profile"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
              //   onTap: () {
              //     Navigator.pop(context); // Close the drawer
              //     updatePage('Profile'); // Update thete the current page
              //   },
              // ),
              ListTile(
                leading: Icon(Icons.logout,color: Colors.white,),
                title: Text(S.of(context, "logout"),style: AppStyle.font18BoldWhite.override(color: Colors.white),),
                onTap: () {
                   _con.logout(context);
                  //updatePage('Logout'); // Update thete the current page
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
