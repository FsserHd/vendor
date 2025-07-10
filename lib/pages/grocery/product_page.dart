

import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';
import 'package:vendor/navigation/page_navigation.dart';
import 'package:vendor/pages/grocery/add_variant_product_page.dart';

import '../../constants/api_constants.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_style.dart';
import '../../controller/home_controller.dart';
import 'add_product_page.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends StateMVC<ProductPage> {

  late HomeController _con;

  _ProductPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getProduct(context);
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
              child: Row(
                children: [
                  Row(
                    children: [
                      Text("Product",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            //_showCustomDialog(context);
                          //  PageNavigation.gotoAddProductPage(context);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddProductPage(),
                              ),
                            ).then((value){
                              _con.groceryProductList.clear();
                              _con.filterGroceryProductList.clear();
                              _con.getProduct(context);
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
                          _con.searchProduct(context, e);
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
            ),
          ),
          Expanded(
            child: _con.filterGroceryProductList.isNotEmpty ? ListView.builder(
                itemCount:  _con.filterGroceryProductList.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var categoryBean =  _con.filterGroceryProductList[index];
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
                                  value: categoryBean.status!  ? true :false,
                                  onChanged: (newValue) async {
                                    _con.productStatus(context, categoryBean.id!, newValue);
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
                                            Image.network(categoryBean.variant!.uploadImage!,height: 50,width: 50,),
                                            SizedBox(height: 5,),

                                          ],
                                        ),
                                        SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(categoryBean.productName!,style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontWeight: FontWeight.bold),),
                                            //Text("Id:${itemBean.id}",style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                                            Row(
                                              children: [
                                                Text(ApiConstants.currency+categoryBean.variant!.salePrice!,style: AppStyle.font14MediumBlack87.override(color: Colors.green,fontWeight: FontWeight.bold),),
                                                SizedBox(width: 5,),
                                                Text(ApiConstants.currency+categoryBean.variant!.strikePrice!,style: AppStyle.font14MediumBlack87.override(color: Colors.grey,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
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
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => AddVariantProductPage(categoryBean.id),
                                        ),
                                      ).then((value){
                                        _con.groceryProductList.clear();
                                        _con.filterGroceryProductList.clear();
                                        _con.getProduct(context);
                                      });
                                    },),
                                    SizedBox(width: 20,),
                                    InkWell(
                                        onTap: (){
                                            _con.deleteProduct(context, categoryBean.id!);
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
                }):Container(),
          )
        ],
      ),
    );
  }
}
