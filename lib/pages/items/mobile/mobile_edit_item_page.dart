

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';


import '../../../constants/app_colors.dart';
import '../../../constants/app_style.dart';
import '../../../controller/home_controller.dart';
import '../../../model/items/add_item_request.dart';
import '../../../model/items/items_model.dart';
import '../../../model/menu/menu_model.dart';

class MobileEditItemPage extends StatefulWidget {

  Productdetails itemBean;

  MobileEditItemPage(this.itemBean, {super.key});

  @override
  _MobileEditItemPageState createState() => _MobileEditItemPageState();
}

class _MobileEditItemPageState extends StateMVC<MobileEditItemPage> {

  late HomeController _con;
  String foodType = 'Select Type';
  Menu? _selectedItem;
  var addEditRequest = AddItemRequest();
  _MobileEditItemPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_con.getMenu(context);
   setState(() {
     // addEditRequest.title = widget.itemBean.productName;
     // addEditRequest.salePrice = widget.itemBean.variant!.salePrice;
     // addEditRequest.quantity = widget.itemBean.variant!.quantity;
     // addEditRequest.tax = widget.itemBean.variant!.tax;
     // addEditRequest.packingCharge = widget.itemBean.variant!.packingCharge;
     if(widget.itemBean.variant!.foodType == "1"){
       foodType = 'Veg';
       _con.addItemRequest.foodType = "1";
     }else{
       foodType = 'Non-Veg';
       _con.addItemRequest.foodType = "2";
     }
     print(widget.itemBean.toJson());
   });
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBgColor,
      appBar: AppBar(
        backgroundColor: AppColors.themeColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text("Edit Item",style: TextStyle(color: Colors.white,fontFamily: AppStyle.robotoRegular),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _con.itemKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Product Title",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
                TextFormField(
                  initialValue: widget.itemBean.productName,
                  onSaved: (e){
                    _con.addItemRequest.title = e;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Product Title',
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
                Text("Product Type",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
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
                          if(foodType =="Veg"){
                            _con.addItemRequest.foodType = "1";
                          }else{
                            _con.addItemRequest.foodType = "2";
                          }
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
                Text("Sale Price",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
                TextFormField(
                  initialValue:  widget.itemBean.variant!.salePrice,
                  onSaved: (e){
                    _con.addItemRequest.salePrice =e;
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
                // Text("Current Stock",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
                // TextFormField(
                //   initialValue:  widget.itemBean.variant!.quantity,
                //   onSaved: (e){
                //     _con.addItemRequest.quantity =e;
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
                Text("Tax %",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
                TextFormField(
                  initialValue:  widget.itemBean.variant!.taxPercentage,
                  onSaved: (e){
                    _con.addItemRequest.tax =e;
                  },
                  keyboardType: TextInputType.number,
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
                SizedBox(height:  10,),

                Text("Packing Charge",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
                TextFormField(
                  initialValue:  widget.itemBean.variant!.packingCharge,
                  onSaved: (e){
                    _con.addItemRequest.packingCharge =e;
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Packing Charge',
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
                Text("Product Image",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
                InkWell(
                    onTap: (){
                      _pickImage();
                    },
                    child:  widget.itemBean.variant!.uploadImage !=null && _image == null ? Image.network(
                      widget.itemBean.variant!.uploadImage!,
                      height: 100,
                      width: 100,
                    ):Image.file(_image!,height: 100,width: 100,)
                ),
                SizedBox(height:  10,),
                InkWell(
                  onTap: (){
                    _con.addItemRequest.varientId = widget.itemBean.variant!.variantId;
                    _con.addItemRequest.productId = widget.itemBean.variant!.productId;
                    _con.addItemRequest.quantity = "0";
                    FocusManager.instance.primaryFocus?.unfocus();
                    _con.itemKey.currentState!.save();
                    print(_con.addItemRequest.toJson());
                    _con.editItem(context, _image);
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
        ),
      ),
    );
  }


}

