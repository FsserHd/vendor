

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/utils/validation_utils.dart';


import '../../../constants/app_colors.dart';
import '../../../constants/app_style.dart';
import '../../../controller/home_controller.dart';
import '../../../language/app_localizations.dart';
import '../../../model/menu/menu_model.dart';

class MobileAddItemPage extends StatefulWidget {

  const MobileAddItemPage({super.key});

  @override
  _MobileAddItemPageState createState() => _MobileAddItemPageState();
}

class _MobileAddItemPageState extends StateMVC<MobileAddItemPage> {

  late HomeController _con;
  String foodType = 'Select Type';
  Menu? _selectedItem;
  String startTime = "Menu Start Time";
  String endTime = "Menu End Time";
  _MobileAddItemPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getMenu(context);
    // if (_con.menuModel.data!.isNotEmpty) {
    //   _selectedItem = _con.menuModel.data![0];
    // }

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
        title: Text("Add Item",style: TextStyle(color: Colors.white,fontFamily: AppStyle.robotoRegular),),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _con.itemKey,
            child: Column(
              children: [
                TextFormField(
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
                _con.menuModel.data!=null ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white, // Light gray background color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    border: Border.all(color: Colors.grey.shade300),
                    // Border color
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<Menu>(
                      hint: Text(
                        'Select Food Type',
                        style: TextStyle(color: Colors.grey), // Customize hint style as needed
                      ),
                      value: _selectedItem,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      onChanged: (Menu? newValue) {
                        setState(() {
                          _selectedItem = newValue!;
                          // Assuming you have a method to handle the category change
                          _con.addItemRequest.category = _selectedItem!.id;
                        });
                      },
                      items: _con.menuModel.data!.map<DropdownMenuItem<Menu>>((Menu item) {
                        return DropdownMenuItem<Menu>(
                          value: item,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(item.categoryName!),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ):Container(),
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

                      value:foodType,
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
                TextFormField(
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
                TextFormField(
                  onSaved: (e){
                    _con.addItemRequest.description =e;
                  },
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Description',
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
              //  SizedBox(height:  10,),
                // TextFormField(
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
                SizedBox(height:  10,),

                TextFormField(
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
                TextFormField(
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
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: InkWell(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        // You can store this in a variable or setState to display
                        print("Selected time: ${pickedTime.format(context)}");
                        String startTime = pickedTime.format(context);
                        _con.addItemRequest.startTime = startTime;
                        setState(() {
                          this.startTime  = startTime;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardShadowColor,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          startTime,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 15),
                Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: InkWell(
                    onTap: () async {
                      TimeOfDay? pickedTime = await showTimePicker(
                        context: context,
                        initialTime: TimeOfDay.now(),
                      );
                      if (pickedTime != null) {
                        // You can store this in a variable or setState to display
                        print("Selected time: ${pickedTime.format(context)}");
                        String endTime = pickedTime.format(context);
                        _con.addItemRequest.endTime = endTime;
                        // this.endTime  = endTime;
                        setState(() {
                          this.endTime  = endTime;
                        });
                      }
                    },
                    child: Container(
                      width: double.infinity,
                      height: 45,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.cardShadowColor,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(0, 1),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Text(
                          endTime,
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 20),
                SizedBox(height:  10,),
                InkWell(
                  onTap: (){
                    _pickImage();
                  },
                  child: _image==null ? Image.asset(
                    "assets/images/upload_image.png",
                    height: 100,
                    width: 100,
                  ):Image.file(_image!,height: 100,width: 100,)
                ),
                SizedBox(height:  10,),
                InkWell(
                  onTap: (){
                    FocusManager.instance.primaryFocus?.unfocus();
                    _con.itemKey.currentState!.save();
                    if(_con.addItemRequest.startTime!=null && _con.addItemRequest.endTime!=null) {
                      _con.addItem(context, _image);
                    }else{
                      ValidationUtils.showAppToast("Select item timing");
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
        ),
      ),
    );
  }

}
