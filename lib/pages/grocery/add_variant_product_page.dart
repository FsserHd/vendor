

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';

import '../../constants/api_constants.dart';
import '../../constants/app_colors.dart';
import '../../constants/app_style.dart';
import '../../controller/home_controller.dart';

class AddVariantProductPage extends StatefulWidget {
  String? id;
  AddVariantProductPage(this.id, {super.key});

  @override
  _AddVariantProductPageState createState() => _AddVariantProductPageState();
}

class _AddVariantProductPageState extends StateMVC<AddVariantProductPage> {

  late HomeController _con;
  String foodType = 'Select Type';
  final TextEditingController _salePriceController = TextEditingController();
  final TextEditingController _strikePriceController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _unitController = TextEditingController();
  final TextEditingController _taxController = TextEditingController();
  String type = "add";
  String editImage = "add";

  _AddVariantProductPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  File? _image;

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
    }
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getProductVariant(context,widget.id!);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Add Product",style: TextStyle(color: Colors.white,fontFamily: AppStyle.robotoRegular),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _con.productVariantModel.data!=null ? Container(
                height: 130,
                child: ListView.builder(
                  shrinkWrap:true,
                  scrollDirection: Axis.horizontal,
                  itemCount: _con.productVariantModel.data!.length,
                    itemBuilder: (context,index){
                    var productVariant = _con.productVariantModel.data![index];
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
                                          children: [
                                            Image.network(productVariant.uploadImage!,height: 50,width: 50,),
                                            SizedBox(height: 5,),

                                          ],
                                        ),
                                        SizedBox(width: 5,),
                                        Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(productVariant.quantity!+" "+productVariant.unit!,style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontWeight: FontWeight.bold),),
                                            //Text("Id:${itemBean.id}",style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                                            Row(
                                              children: [
                                                Text(ApiConstants.currency+productVariant.salePrice!,style: AppStyle.font14MediumBlack87.override(color: Colors.green,fontWeight: FontWeight.bold),),
                                                SizedBox(width: 5,),
                                                Text(ApiConstants.currency+productVariant.strikePrice!,style: AppStyle.font14MediumBlack87.override(color: Colors.grey,fontWeight: FontWeight.bold,decoration: TextDecoration.lineThrough),),
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
                                        onTap: (){
                                          //_con.deleteVariant(context, productVariant.variantId!,widget.id);
                                        setState(() {
                                         _strikePriceController.text = productVariant.strikePrice!.toString();
                                         _con.addProductVariantRequest.variantId = int.parse(productVariant.variantId!);
                                         _salePriceController.text = productVariant.salePrice!.toString();
                                         _quantityController.text = productVariant.quantity!.toString();
                                         _unitController.text = productVariant.unit!.toString();
                                         _taxController.text = productVariant.taxPercentage!.toString();
                                         type = "edit";
                                         editImage = productVariant.uploadImage.toString();
                                        });
                                        },
                                        child: Image.asset("assets/images/edit.png",height: 35,width: 35,)),
                                   SizedBox(width: 10),
                                    InkWell(
                                        onTap: (){
                                         _con.deleteVariant(context, productVariant.variantId!,widget.id);
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
                }),
              ):Container(),
              Form(
                key: _con.itemKey,
                child: Column(
                  children: [
                    TextFormField(
                      onSaved: (e){
                        _con.addProductVariantRequest.salePrice = double.parse(e!);
                      },
                      controller: _salePriceController,
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
                    TextFormField(
                      onSaved: (e){
                        _con.addProductVariantRequest.strikePrice = double.parse(e!);
                      },

                      keyboardType: TextInputType.number,
                      controller: _strikePriceController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Strike Price',
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

                    TextFormField(
                      onSaved: (e){
                        _con.addProductVariantRequest.quantity =int.parse(e!);
                      },
                      keyboardType: TextInputType.number,
                      controller: _quantityController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Quantity',
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
                    TextFormField(
                      onSaved: (e){
                        _con.addProductVariantRequest.unit =e;
                      },
                      keyboardType: TextInputType.text,
                      controller: _unitController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Unit(Ex: kg,unit)',
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
                    TextFormField(
                      onSaved: (e){
                        _con.addProductVariantRequest.tax =int.parse(e!);
                      },
                      keyboardType: TextInputType.number,
                      controller: _taxController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.white,
                        hintText: 'Tax %',
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

                    //
                    // TextFormField(
                    //   onSaved: (e){
                    //     _con.addItemRequest.discount =e;
                    //   },
                    //   keyboardType: TextInputType.number,
                    //   decoration: InputDecoration(
                    //     filled: true,
                    //     fillColor: Colors.white,
                    //     hintText: 'Discount for price',
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
                    SizedBox(height:  10,),
                    InkWell(
                        onTap: (){
                            _pickImage();
                        },
                        child: type == "add" ?  _image==null ? Image.asset(
                          "assets/images/upload_image.png",
                          height: 100,
                          width: 100,
                        ):Image.file(_image!,height: 100,width: 100,):Image.network(editImage,height: 100,width: 100,)
                    ),

                    SizedBox(height:  10,),
                    InkWell(
                      onTap: (){
                        FocusManager.instance.primaryFocus?.unfocus();
                        _con.itemKey.currentState!.save();
                        if(type == "add") {
                          _con.addProductVariant(context, _image, widget.id);
                        }else{
                          print(_con.addProductVariantRequest.toJson());
                         _con.editProductVariant(context, _image,widget.id);
                        }
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
