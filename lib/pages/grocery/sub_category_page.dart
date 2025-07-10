

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';
import 'package:vendor/model/subcategory/sub_category_model.dart';

import '../../constants/app_colors.dart';
import '../../constants/app_style.dart';
import '../../controller/home_controller.dart';
import '../../model/menu/menu_model.dart';

class SubCategoryPage extends StatefulWidget {
  const SubCategoryPage({super.key});

  @override
  _SubCategoryPageState createState() => _SubCategoryPageState();
}

class _SubCategoryPageState extends StateMVC<SubCategoryPage> {

  late HomeController _con;
  Menu? _selectedItem;

  _SubCategoryPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getSubCategory(context);
    _con.getMenu(context);
  }

  File? _image;

  Future<void> _pickImage(Function(File?) updateImage) async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      updateImage(File(pickedFile.path));
    }
  }

  void _showEditMenuDialog(BuildContext context, SubCategory categoryBean) {
    var categoryController = TextEditingController(text: categoryBean.subcategoryName!);
    _con.menuModel.data!.forEach((element) {
      if(element.id ==  categoryBean.categoryId){
        setState(() {
          _selectedItem = element;
        });
      }
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            File? dialogImage = _image;

            void updateImage(File? newImage) {
              setState(() {
                dialogImage = newImage;
                _image = newImage; // Update the parent state if needed
              });
            }

            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 450,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Edit Sub Category',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[400],
                        ),
                        child: TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            hintText: 'Sub Category Name',
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Sub Category Image',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _pickImage(updateImage);
                        },
                        child: dialogImage != null
                            ? Image.file(
                          dialogImage!,
                          height: 100,
                          width: 100,
                        )
                            : Image.network(
                          categoryBean.image!,
                          height: 100,
                          width: 100,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _con.editSubCategory(context,categoryController.text,_image,categoryBean.id);
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  void _showCustomDialog(BuildContext context) {
    var categoryController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            File? dialogImage = _image;

            void updateImage(File? newImage) {
              setState(() {
                dialogImage = newImage;
                _image = newImage; // Update the parent state if needed
              });
            }

            return Dialog(
              backgroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 450,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Add Sub Category',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(Icons.close),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),
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
                      SizedBox(height: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.0),
                          color: Colors.grey[400],
                        ),
                        child: TextField(
                          controller: categoryController,
                          decoration: InputDecoration(
                            hintText: 'Category Name',
                            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10.0),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Category Image',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _pickImage(updateImage);
                        },
                        child: dialogImage != null
                            ? Image.file(
                          dialogImage!,
                          height: 100,
                          width: 100,
                        )
                            : Image.asset(
                          "assets/images/upload_image.png",
                          height: 100,
                          width: 100,
                        ),
                      ),
                      SizedBox(height: 10),
                      InkWell(
                        onTap: () {
                          _con.addSubCategoryMenu(context,categoryController.text,_image);
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
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
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
                      Text("Sub Category",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                      SizedBox(width: 10,),
                      InkWell(
                          onTap: (){
                            _showCustomDialog(context);
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
                          _con.searchSubCategory(context, e);
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
            child: _con.subCategoryModel.data!=null ? ListView.builder(
                itemCount: _con.filterSubCategoryModel.data!.length,
                shrinkWrap: true,
                itemBuilder: (context,index){
                  var categoryBean = _con.filterSubCategoryModel.data![index];
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
                                  value: categoryBean.status == "1" ? true :false,
                                  onChanged: (newValue) async {
                                    _con.statusSubCategory(context, categoryBean.id!, newValue);
                                  },
                                  activeColor: Colors.white,
                                  activeTrackColor: Colors.green,
                                  inactiveTrackColor: Colors.grey,
                                  inactiveThumbColor: FlutterFlowTheme.of(context).secondaryText,
                                ),
                                SizedBox(width: 5,),
                                Image.network(categoryBean.image!,height: 50,width: 50,),
                                SizedBox(width: 5,),
                                Text(categoryBean.subcategoryName!,style: AppStyle.font14MediumBlack87.override(color: Colors.black),),
                              ],
                            ),
                            SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                InkWell(
                                  child: Image.asset("assets/images/edit.png",height: 35,width: 35,),onTap: (){

                                  _showEditMenuDialog(context,categoryBean);
                                },),
                                SizedBox(width: 30,),
                                InkWell(
                                    onTap: (){
                                      _con.deleteSubCategory(context, categoryBean.id!);
                                    },
                                    child: Image.asset("assets/images/delete.png",height: 35,width: 35,)),
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
