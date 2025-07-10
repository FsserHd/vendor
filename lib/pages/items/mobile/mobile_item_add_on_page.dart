

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/constants/api_constants.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_style.dart';
import '../../../controller/home_controller.dart';

class MobileItemAddOnPage extends StatefulWidget {
  String? id;
  MobileItemAddOnPage(this.id, {super.key});

  @override
  _MobileItemAddOnPageState createState() => _MobileItemAddOnPageState();
}

class _MobileItemAddOnPageState extends StateMVC<MobileItemAddOnPage> {


  late HomeController _con;
  String foodType = 'Select Type';

  _MobileItemAddOnPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listAddOnItem(context, widget.id!);
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
        title: Text("Add Add On",style: TextStyle(color: Colors.white,fontFamily: AppStyle.robotoRegular),),
        centerTitle: true,
      ),
      body:  SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _con.addOnItemModel.data!=null ? Container(
                height: 120,
                width: 120,
                child: ListView.builder(
                  shrinkWrap: true,
                    itemCount: _con.addOnItemModel.data!.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context,index){
                    var addOnSet = _con.addOnItemModel.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
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
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Row(
                                              children: [
                                                Image.asset("assets/images/non_veg.png",height: 15,width: 15,),
                                                SizedBox(width: 2,),
                                                Text(addOnSet.name!,style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontWeight: FontWeight.bold),),
                                              ],
                                            ),
                                            Text("${ApiConstants.currency+addOnSet.salesPrice!}",style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                                            SizedBox(height: 8,),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: InkWell(child: Icon(Icons.delete,color: Colors.red,size: 20,),onTap: (){
                                                _con.deleteAddOn(context, addOnSet.addonId!,widget.id);
                                              },),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5,),

                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              ):Container(),
              Form(
                key: _con.itemKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (e){
                        _con.addOnRequest.name = e;
                      },
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Product Name',
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
                          value: foodType,
                          icon: Icon(Icons.arrow_drop_down),
                          iconSize: 24,
                          elevation: 16,
                          style: TextStyle(color: Colors.black, fontSize: 16),
                          onChanged: (String? newValue) {
                            setState(() {
                              foodType = newValue!;
                              _con.addOnRequest.foodType = newValue;
                            });
                          },
                          items: _con.foodTypeList.map<DropdownMenuItem<String>>((String value) {
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
                    TextFormField(
                      onSaved: (e){
                        _con.addOnRequest.salesPrice =e;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Sale Price',
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
                    // TextFormField(
                    //   onSaved: (e){
                    //     _con.addOnRequest.stock =e;
                    //   },
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     hintText: 'Current Stock',
                    //     contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    //     border: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       borderSide: BorderSide(
                    //         color: Colors.grey.shade300, // Light gray border color
                    //         width: 1.0,
                    //       ),
                    //     ),
                    //     enabledBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       borderSide: BorderSide(
                    //         color: Colors.grey.shade300, // Light gray border color
                    //         width: 1.0,
                    //       ),
                    //     ),
                    //     focusedBorder: OutlineInputBorder(
                    //       borderRadius: BorderRadius.circular(10.0),
                    //       borderSide: BorderSide(
                    //         color: Colors.blue, // Blue border color when focused
                    //         width: 2.0,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height:  10,),

                    TextFormField(
                      onSaved: (e){
                        _con.addOnRequest.tax =e;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Tax',
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
                        _con.itemKey.currentState!.save();
                        _con.addOnRequest.stock = "0";
                        _con.addOnItem(context,widget.id);
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
            ],
          ),
        ),
      ),
    );
  }
}
