


import 'dart:async';

import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor/constants/app_colors.dart';
import 'package:vendor/navigation/page_navigation.dart';

import '../../utils/preference_utils.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    requestBatteryOptimization();
    Timer(const Duration(seconds: 3), () async {
      String? userId = await PreferenceUtils.getUserId();
      if(userId!=null){
        PageNavigation.gotoHomePage(context);
      }else{
        PageNavigation.gotoLoginScreen(context);
      }
    });
  }

  Future<void> requestBatteryOptimization() async {
    final intent = AndroidIntent(
      action: 'android.settings.REQUEST_IGNORE_BATTERY_OPTIMIZATIONS',
      package: 'com.fsserhd.vendor',
    );
    await intent.launch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.themeColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
            Image.asset("assets/images/splash.png",height: 350,width: 350,),
          ],
        ),
      ),
    );
  }
}
