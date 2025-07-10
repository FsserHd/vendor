

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:vendor/constants/app_colors.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';

import '../../../constants/app_style.dart';

class MobileReviewPage extends StatefulWidget {
  const MobileReviewPage({super.key});

  @override
  State<MobileReviewPage> createState() => _MobileReviewPageState();
}

class _MobileReviewPageState extends State<MobileReviewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBgColor,
      body: Center(
        child: Column(
          children: [
            Text("No Reviews found",style: AppStyle.font18BoldWhite.override(color: Colors.black)),
          ],
        ),
      ),
    );
  }
}
