

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/constants/app_colors.dart';
import 'package:vendor/constants/app_style.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';

import '../../../controller/home_controller.dart';

class MobileDiscountPage extends StatefulWidget {
  const MobileDiscountPage({super.key});

  @override
  _MobileDiscountPageState createState() => _MobileDiscountPageState();
}

class _MobileDiscountPageState extends StateMVC<MobileDiscountPage> {


  late HomeController _con;


  _MobileDiscountPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getDiscount(context);
  }
  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: AppColors.dashboardBgColor,
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white, // Light gray background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
                border: Border.all(color: Colors.grey.shade300), // Border color
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _con.discountType,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue) {
                    setState(() {
                      _con.discountType = newValue!;
                    });
                  },
                  items: _con.discountTypeList.map<DropdownMenuItem<String>>((String value) {
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
            SizedBox(height:  10,),
            Text("Discount",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
            SizedBox(height: 2,),
            TextFormField(
              controller: _con.discountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Discount',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300, // Light gray border color
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300, // Light gray border color
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue, // Blue border color when focused
                    width: 2.0,
                  ),
                ),
              ),
            ),
            SizedBox(height:  10,),
            Text("Minimum Purchase Amount ",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
            SizedBox(height: 2,),
            TextFormField(
              controller: _con.minOrderController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Enter Min Order Price',
                contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300, // Light gray border color
                    width: 1.0,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.grey.shade300, // Light gray border color
                    width: 1.0,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(
                    color: Colors.blue, // Blue border color when focused
                    width: 2.0,
                  ),
                ),
              ),
            ),
            SizedBox(height:  10,),
            InkWell(
              onTap: (){
                FocusManager.instance.primaryFocus?.unfocus();
                _con.addDiscount(context, _con.discountType, _con.discountController.text,_con.minOrderController.text);
              },
              child: Container(
                width: double.infinity,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
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
    );
  }
}
