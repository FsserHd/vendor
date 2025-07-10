

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/model/subcategory/sub_category_model.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_style.dart';
import '../../controller/home_controller.dart';
import '../../model/menu/menu_model.dart';

class AddProductPage extends StatefulWidget {

  const AddProductPage({super.key});

  @override
  _AddProductPageState createState() => _AddProductPageState();
}

class _AddProductPageState extends StateMVC<AddProductPage> {


  late HomeController _con;
  String foodType = 'Select Type';
  SubCategory? _selectedItem;
  Menu? _selectedCategory;
  _AddProductPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    //_con.getSubCategory(context);
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
        title: Text("Add Product",style: TextStyle(color: Colors.white,fontFamily: AppStyle.robotoRegular),),
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
                    _con.addProductRequest.productTitle = e;
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
                        'Select Category',
                        style: TextStyle(color: Colors.grey), // Customize hint style as needed
                      ),
                      value: _selectedCategory,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      onChanged: (Menu? newValue) {
                        setState(() {
                          _selectedCategory = newValue!;
                          print(_selectedCategory!.toJson());
                          // Assuming you have a method to handle the category change
                          _con.addProductRequest.category = int.parse(_selectedCategory!.id!);
                          _con.getSubCategory(context);
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
                _con.subCategoryModel.data!=null ? Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white, // Light gray background color
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    border: Border.all(color: Colors.grey.shade300),
                    // Border color
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<SubCategory>(
                      hint: Text(
                        'Select Sub Category',
                        style: TextStyle(color: Colors.grey), // Customize hint style as needed
                      ),
                      value: _selectedItem,
                      icon: Icon(Icons.arrow_drop_down),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: Colors.black, fontSize: 16),
                      onChanged: (SubCategory? newValue) {
                        setState(() {
                          _selectedItem = newValue!;
                          // Assuming you have a method to handle the category change
                          _con.addProductRequest.subCategory = int.parse(_selectedItem!.id!);
                        });
                      },
                      items: _con.subCategoryModel.data!.map<DropdownMenuItem<SubCategory>>((SubCategory item) {
                        return DropdownMenuItem<SubCategory>(
                          value: item,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10),
                            child: Text(item.subcategoryName!),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ):Container(),
                SizedBox(height:  10,),
                TextFormField(
                  onSaved: (e){
                    _con.addProductRequest.salePrice = double.parse(e!);
                  },
                  initialValue: 0.0.toString(),
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
                    _con.addProductRequest.strikePrice = double.parse(e!);
                  },
                  initialValue: 0.0.toString(),
                  keyboardType: TextInputType.number,
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
                    _con.addProductRequest.description =e;
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
                SizedBox(height:  10,),
                TextFormField(
                  onSaved: (e){
                    _con.addProductRequest.quantity =int.parse(e!);
                  },
                  keyboardType: TextInputType.number,
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
                    _con.addProductRequest.unit =e;
                  },
                  keyboardType: TextInputType.text,
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
                    _con.addProductRequest.tax =int.parse(e!);
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
                TextFormField(
                  onSaved: (e){
                    _con.addProductRequest.stock =int.parse(e!);
                  },
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Current Stock',
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
                    _con.addProduct(context, _image);
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
