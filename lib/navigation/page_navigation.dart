

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vendor/model/order/order_model.dart';
import 'package:vendor/pages/chat/chat_page.dart';
import 'package:vendor/pages/customer_chat/cutomer_chat_page.dart';
import 'package:vendor/pages/grocery/add_product_page.dart';
import 'package:vendor/pages/home/home_page.dart';
import 'package:vendor/pages/items/mobile/mobile_add_item_page.dart';
import 'package:vendor/pages/items/mobile/mobile_item_add_on_page.dart';
import 'package:vendor/pages/login/login_page.dart';
import 'package:vendor/pages/orders/mobile/mobile_order_details_page.dart';

class PageNavigation{

  static gotoLoginScreen(BuildContext context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const LoginPage(),
      ),
    );
  }

  static gotoHomePage(BuildContext context){
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const HomePage(),
      ),
    );
  }

  static gotoCustomerChatPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CustomerChatPage(),
      ),
    );
  }
  static gotoMobileOrderDetails(BuildContext context, Data dataBean){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MobileOrderDetailsPage(dataBean),
      ),
    );
  }
  static gotoMobileAddItemPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MobileAddItemPage(),
      ),
    );
  }

  static gotoAddProductPage(BuildContext context){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddProductPage(),
      ),
    );
  }


  static gotoMobileAddOnPage(BuildContext context, String? id){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MobileItemAddOnPage(id),
      ),
    );
  }

  static gotoChatPage(BuildContext context, String s,String type,String sender){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>  ChatPage(s,type,sender),
      ),
    );
  }

  static gotoDialPage(BuildContext context,String mobile) async {
    await FlutterPhoneDirectCaller.callNumber(mobile);
  }


  static goLogout(BuildContext context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.clear();
    gotoLoginScreen(context);
  }

}