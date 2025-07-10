

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/constants/api_constants.dart';
import 'package:vendor/navigation/page_navigation.dart';
import 'package:vendor/pages/items/mobile/mobile_edit_item_page.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_style.dart';
import '../../../controller/home_controller.dart';
import '../../../flutter_flow/flutter_flow_theme.dart';
import '../../../model/items/items_model.dart';
import 'mobile_add_item_page.dart';

class MobileItemPage extends StatefulWidget {
  const MobileItemPage({super.key});

  @override
  _MobileItemPageState createState() => _MobileItemPageState();
}

class _MobileItemPageState extends StateMVC<MobileItemPage> {

  late HomeController _con;
  String _selectedItem = 'All';

  _MobileItemPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getItems(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBgColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    children: [
                      Row(
                        children: [
                          Text("Items",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                          SizedBox(width: 10,),
                          InkWell(
                              onTap: (){
                               // PageNavigation.gotoMobileAddItemPage(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => MobileAddItemPage(),
                                  ),
                                ).then((value){
                                  _con.getItems(context);
                                });
                              },
                              child: Image.asset("assets/images/plus.png",height: 30,width: 30,)),

                        ],
                      ),
                      SizedBox(width: 20,),
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                            color: Colors.grey[200], // Gray fill color
                          ),
                          child: TextField(
                            onChanged: (e){
                              _con.searchItemMenu(context, e);
                            },
                            decoration: InputDecoration(
                              hintText: 'Search',
                              prefixIcon: Icon(Icons.search),
                              border: InputBorder.none, // Remove default border
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0), // Optional: Adjust padding
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 10,),
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
                        value: _selectedItem,
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.black, fontSize: 16),
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedItem = newValue!;
                            _con.getItemByMenu(context,_selectedItem);
                          });
                        },
                        items: _con.menuList.map<DropdownMenuItem<String>>((String value) {
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
                ],
              ),
            ),
          ),
          Expanded(
            child:  _con.filterItemList.isNotEmpty ? ListView.builder(
                itemCount: _con.filterItemList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  Productdetails itemBean = _con.filterItemList[index];
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
                                Switch.adaptive(
                                  value: itemBean.status!,
                                  onChanged: (newValue) async {
                                    _con.statusItem(context, itemBean.id!, newValue);
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  inactiveTrackColor: Colors.grey,
                                  inactiveThumbColor: FlutterFlowTheme.of(context).secondaryText,
                                ),
                                SizedBox(width: 5,),
                                Column(
                                  children: [
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Image.network(itemBean.variant!.uploadImage!,height: 50,width: 50,),
                                            SizedBox(height: 5,),

                                          ],
                                        ),
                                        SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(itemBean.productName!,style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontWeight: FontWeight.bold),),
                                            //Text("Id:${itemBean.id}",style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                                            Text(ApiConstants.currency+itemBean.variant!.salePrice!,style: AppStyle.font14MediumBlack87.override(color: Colors.green,fontWeight: FontWeight.bold),),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(width: 5,),

                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      child: Image.asset("assets/images/add.png",height: 35,width: 35,),onTap: (){
                                        PageNavigation.gotoMobileAddOnPage(context,itemBean.id);
                                    },),
                                    SizedBox(width: 20,),
                                    InkWell(
                                      child: Image.asset("assets/images/edit.png",height: 35,width: 35,),onTap: (){
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => MobileEditItemPage(itemBean),
                                        ),
                                      ).then((value){
                                        _con.getItems(context);
                                      });
                                    },),
                                    SizedBox(width: 20,),
                                    InkWell(
                                        onTap: (){
                                          _con.deleteItem(context, itemBean.id!);
                                        },
                                        child: Image.asset("assets/images/delete.png",height: 35,width: 35,)),
                                  ],
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  );
                }):Container()
          )
        ],
      ),
    );
  }
}
