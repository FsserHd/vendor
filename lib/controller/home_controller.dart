

import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';
import 'package:vendor/model/account/account_model.dart';
import 'package:vendor/model/dashboard/dashboard_model.dart';
import 'package:vendor/model/discount/discount_model.dart';
import 'package:vendor/model/driver/driver_model.dart';
import 'package:vendor/model/firebase/firebase_order_response.dart';
import 'package:vendor/model/items/add_item_request.dart';
import 'package:vendor/model/items/add_on_item_model.dart';
import 'package:vendor/model/items/add_on_request.dart';
import 'package:vendor/model/items/items_model.dart';
import 'package:vendor/model/menu/menu_model.dart';
import 'package:vendor/model/product/add_product_request.dart';
import 'package:vendor/model/product/add_product_variant_request.dart';

import 'package:vendor/model/product/product_model.dart';
import 'package:vendor/model/product/product_variant_model.dart';
import 'package:vendor/model/shop/shop_model.dart';
import 'package:vendor/model/zone/zone_information_model.dart';
import 'package:vendor/pages/dashboard/mobile/mobile_dashboard_page.dart';
import 'package:vendor/utils/preference_utils.dart';
import 'package:vendor/utils/time_utils.dart';

import '../constants/api_constants.dart';
import '../constants/app_colors.dart';
import '../constants/app_style.dart';
import '../constants/lang.dart';
import '../model/chat/chat_request.dart';
import '../model/chat/chat_response.dart';
import '../model/common/common_response_model.dart';
import '../model/order/order_model.dart';
import '../model/subcategory/sub_category_model.dart';
import '../navigation/page_navigation.dart';
import '../network/api_service.dart';
import '../pages/orders/mobile/mobile_order_page.dart';
import '../utils/loader.dart';
import '../utils/validation_utils.dart';

class HomeController extends ControllerMVC{

  final GlobalKey<FormState> itemKey = GlobalKey<FormState>();
  ApiService apiService = ApiService();
  var commonModel = CommonResponseModel();
  var discountModel = DiscountModel();
  var itemModel = ItemModel();
  var filterItemModel = ItemModel();
  var productModel =  ProductModel();
  var productVariantModel =  ProductVariantModel();
  List<GroceryProductDetails> groceryProductList =  [];
  List<GroceryProductDetails> filterGroceryProductList =  [];
  var filterProductModel = ProductModel();
  var menuModel = MenuModel();
  var subCategoryModel = SubCategoryModel();
  var filterMenuModel = MenuModel();
  var filterSubCategoryModel = SubCategoryModel();
  var _dashboardModel = DashboardModel();
  DashboardModel get dashboardModel => _dashboardModel;
  var orderModel = OrderModel();
  var addOnItemModel = AddOnItemModel();
  var driverModel = DriverModel();
  var addItemRequest = AddItemRequest();
  var addProductRequest = AddProductRequest();
  var addProductVariantRequest = AddProductVariantRequest();
  var addOnRequest = AddOnRequest();
  var isShopStatus = false;
  var totalAmount = 0;
  var foodTypeList = ['Select Type','Veg','Non-Veg'];
  var discountTypeList = ['Select Type','Percentage','Flat'];
  var chatResponse = ChatResponse();
  var zoneInformationModel = ZoneInformationModel();
  var accountModel = AccountModel();
  var chatRequest = ChatRequest();
  var discountController = TextEditingController();
  var minOrderController = TextEditingController();
  var discountType = "Select Type";
  MobileOrderPage mobileOrderPage =  MobileOrderPage();



  updateLiveStatus(BuildContext context, bool newValue){
    Loader.show();
    apiService.updateLiveStatus(newValue.toString()).then((value) {
      Loader.hide();
      getUserLiveStatus(context);
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  getUserLiveStatus(BuildContext context){
    Loader.show();
    apiService.getUserLiveStatus().then((value) {
      Loader.hide();
      setState(() {
        if(value.success!){
          isShopStatus = true;
        }else{
          isShopStatus = false;
        }
      });
    }).catchError((e) {
      Loader.hide();
    //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  getDashboard(BuildContext context){
    Loader.show();
    apiService.getDashBoard().then((value) {
      Loader.hide();
      _dashboardModel = value;
      if(_dashboardModel.zonestatus == "failed"){
        showConfirmationBottomSheet(context);
      }
      PreferenceUtils.saveZoneId(_dashboardModel.zoneId!);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
    // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  Future<bool?> showConfirmationBottomSheet(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      enableDrag: false,
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: EdgeInsets.all(16.0),
          height: 180,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Text(
                'Service Not Available',
                style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 16),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Sorry! currently not available your location. Please contact your admin.',
                style: AppStyle.font14MediumBlack87.override(color: Colors.black,fontSize: 13),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 15),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  InkWell(
                    onTap: (){
                      SystemNavigator.pop();
                      exit(0);
                    },
                    child: Container(
                      width: 138,
                      height: 48,
                      decoration: BoxDecoration(
                        color: AppColors.themeColor, // Gray fill color
                        borderRadius: BorderRadius.circular(15.0), // Rounded corners
                      ),
                      child: Center(
                        child:   Text("Close",style: AppStyle.font14MediumBlack87.override(color: Colors.white)),
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        );
      },
    ).then((value) async {
      if (value == true) {
        return  true;
      } else {
        return  false;
      }
    });
  }

  getOrders(BuildContext context, String s){
    Loader.show();
    apiService.getOrders(s).then((value) {
      Loader.hide();
      orderModel = value;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
    //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }
  getPayoutOrders(BuildContext context, String s){
    Loader.show();
    apiService.getPayoutOrders(s).then((value) {
      Loader.hide();
      orderModel = value;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
    //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  ordersStatusUpdate(BuildContext context,String orderId,String status, String selectedItem, String dStatus){
    Loader.show();
    apiService.orderStatusUpdate(orderId,status,dStatus).then((value) async {
      MobileDashboardPage().createState().updatePage(context);
      Loader.hide();
      commonModel = value;
      if(dStatus == "on_cancel"){
        String? pageName = await PreferenceUtils.getCurrentPage();
        if(pageName!=null) {
          if (pageName.contains("Orders")) {
            getOrders(context, "all");
          }else{
            Navigator.pop(context);
          }
        }
      }else {
        getOrders(context, selectedItem);
      }
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  setCookingTime(BuildContext context,String orderId, String text, String selectedItem){
    Loader.show();
    apiService.setCookingTime(orderId,text).then((value) {
      Loader.hide();
      commonModel = value;
      ordersStatusUpdate(context,orderId,"Accepted","all","on_track");
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  setInitialCookingTime(BuildContext context,String orderId, String text, String selectedItem){
    Loader.show();
    apiService.setCookingTime(orderId,text).then((value) async {

      Loader.hide();
      commonModel = value;
      apiService.orderStatusUpdate(orderId,"Accepted","on_track").then((value) {
        Loader.hide();
        commonModel = value;
        MobileDashboardPage().createState().updatePage(context);
        ValidationUtils.showAppToast("Successfully Updated");
        Navigator.pop(context);
      }).catchError((e) {
        Loader.hide();
       // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }).catchError((e) {
      Navigator.pop(context);
      Loader.hide();
      //ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  getMenu(BuildContext context){
    Loader.show();
    apiService.getMenu().then((value) {
      Loader.hide();
      menuModel = value;
      filterMenuModel = value;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  getSubCategory(BuildContext context){
    Loader.show();
    apiService.getSubCategory(addProductRequest.category.toString()).then((value) {
      Loader.hide();
      subCategoryModel = value;
      filterSubCategoryModel = value;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
      //ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  getProduct(BuildContext context){
    Loader.show();
    apiService.getProducts().then((value) {
      Loader.hide();
      productModel = value;
      filterProductModel = value;
      productModel.data!.forEach((element) {
        element.productdetails!.forEach((element) {
          setState(() {
            groceryProductList.add(element);
            filterGroceryProductList.add(element);
          });
        });
      });
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  getProductVariant(BuildContext context, String productId){
    Loader.show();
    apiService.getProductVariant(productId).then((value) {
      Loader.hide();
      productVariantModel = value;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  searchMenu(BuildContext context,String query){
    filterMenuModel = MenuModel();
    setState(() {
      filterMenuModel.data = menuModel.data!
          .where((element) => element.categoryName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }


  searchSubCategory(BuildContext context,String query){
    filterSubCategoryModel = SubCategoryModel();
    setState(() {
      filterSubCategoryModel.data = subCategoryModel.data!
          .where((element) => element.subcategoryName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  addMenu(BuildContext context, String category, File? image){
    if(ValidationUtils.emptyValidation(category)) {
      Loader.show();
      apiService.addMenu(category, image).then((value) {
        Loader.hide();
        commonModel = value;
        if (commonModel.success!) {
          Navigator.pop(context);
          getMenu(context);
          ValidationUtils.showAppToast("Menu Added Successfully");
        }
        notifyListeners();
      }).catchError((e) {
        Loader.hide();
       // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("Category Name Required");
    }
  }

  addSubCategoryMenu(BuildContext context, String category, File? image){
    if(ValidationUtils.emptyValidation(category)) {
      Loader.show();
      apiService.addSuCategoryMenu(category, image,addItemRequest.category!).then((value) {
        Loader.hide();
        commonModel = value;
        if (commonModel.success!) {
          Navigator.pop(context);
          getSubCategory(context);
          ValidationUtils.showAppToast("Menu Added Successfully");
        }
        notifyListeners();
      }).catchError((e) {
        Loader.hide();
      //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("Category Name Required");
    }
  }

  editMenu(BuildContext context, String category, File? image, String? id){
    if(ValidationUtils.emptyValidation(category)) {
      Loader.show();
      apiService.editMenu(category, image,id).then((value) {
        Loader.hide();
        commonModel = value;
        if (commonModel.success!) {
          Navigator.pop(context);
          getMenu(context);
          ValidationUtils.showAppToast("Menu Added Successfully");
        }
        notifyListeners();
      }).catchError((e) {
        Loader.hide();
      //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("Category Name Required");
    }
  }

  editSubCategory(BuildContext context, String category, File? image, String? id){
    if(ValidationUtils.emptyValidation(category)) {
      Loader.show();
      apiService.editSubCategory(category, image,id, addItemRequest.category!).then((value) {
        Loader.hide();
        commonModel = value;
        if (commonModel.success!) {
          Navigator.pop(context);
          getMenu(context);
          ValidationUtils.showAppToast("Menu Added Successfully");
        }
        notifyListeners();
      }).catchError((e) {
        Loader.hide();
     //   ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("Category Name Required");
    }
  }

  deleteMenu(BuildContext context,String catId){
    Loader.show();
    apiService.deleteMenu(catId).then((value) {
      Loader.hide();
      commonModel = value;
      getMenu(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  deleteProduct(BuildContext context,String productId){
    Loader.show();
    apiService.deleteProduct(productId).then((value) {
      Loader.hide();
      commonModel = value;
      filterGroceryProductList.clear();
      groceryProductList.clear();
      getProduct(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  deleteVariant(BuildContext context,String productId, String? id){
    Loader.show();
    apiService.deleteVariant(productId).then((value) {
      Loader.hide();
      commonModel = value;
      getProductVariant(context,id!);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
    //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  deleteSubCategory(BuildContext context,String catId){
    Loader.show();
    apiService.deleteSubCategory(catId).then((value) {
      Loader.hide();
      commonModel = value;
      getSubCategory(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  statusMenu(BuildContext context,String catId,bool status){
    Loader.show();
    String menuStatus = "0";
    if(status){
      menuStatus = "1";
    }else{
      menuStatus = "0";
    }
    apiService.statusMenu(catId,menuStatus).then((value) {
      Loader.hide();
      commonModel = value;
      getMenu(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  statusSubCategory(BuildContext context,String catId,bool status){
    Loader.show();
    String menuStatus = "0";
    if(status){
      menuStatus = "1";
    }else{
      menuStatus = "0";
    }
    apiService.statusSubCategory(catId,menuStatus).then((value) {
      Loader.hide();
      commonModel = value;
      getSubCategory(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  productStatus(BuildContext context,String catId,bool status){
    Loader.show();
    String menuStatus = "0";
    if(status){
      menuStatus = "true";
    }else{
      menuStatus = "false";
    }
    apiService.productStatus(catId,menuStatus).then((value) {
      Loader.hide();
      commonModel = value;
      groceryProductList.clear();
      getProduct(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }



  var itemList = <Productdetails>[];
  var filterItemList = <Productdetails>[];
  var menuList = <String>[];
  getItems(BuildContext context){
    itemList.clear();
    menuList.clear();
    filterItemList.clear();
    Loader.show();
    apiService.getItems().then((value) {
      Loader.hide();
      itemModel = value;
      filterItemModel = value;
      menuList.add("All");
      itemModel.data!.forEach((element) {
        menuList.add(element.categoryName!);
        element.productdetails!.forEach((element) {
          itemList.add(element);
          filterItemList.add(element);
        });
      });
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  searchItemMenu(BuildContext context,String query){
    filterItemList.clear();
    setState(() {
      filterItemList = itemList
          .where((element) => element.productName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  searchProduct(BuildContext context,String query){
    filterGroceryProductList.clear();
    setState(() {
      filterGroceryProductList = groceryProductList
          .where((element) => element.productName!.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  getItemByMenu(BuildContext context,String menuName){
    filterItemList.clear();
    itemModel.data!.forEach((element) {
      if(menuName !="All") {
        if (element.categoryName == menuName) {
          element.productdetails!.forEach((element) {
            filterItemList.add(element);
          });
        }
      }else{
        element.productdetails!.forEach((element) {
          filterItemList.add(element);
        });
      }
    });
    notifyListeners();
  }

  addItem(BuildContext context,File? image){
    if(ValidationUtils.emptyValidation(addItemRequest.title!)
        && ValidationUtils.emptyValidation(addItemRequest.category!)
        && ValidationUtils.emptyValidation(addItemRequest.foodType!)
        && ValidationUtils.emptyValidation(addItemRequest.salePrice!)
        && ValidationUtils.emptyValidation(addItemRequest.description!)
        && ValidationUtils.emptyValidation(addItemRequest.tax!)
        && ValidationUtils.emptyValidation(addItemRequest.packingCharge!) && image!=null) {
      Loader.show();
      addItemRequest.quantity = "0";
      // var tax = (double.parse(addItemRequest.salePrice!) * double.parse(addItemRequest.tax!))/100;
      // addItemRequest.tax = tax.toStringAsFixed(0);
      apiService.addItem(image, addItemRequest).then((value) {
        Loader.hide();
        commonModel = value;
        Navigator.pop(context);
      }).catchError((e) {
        Loader.hide();
      //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("All Fields are required.");
    }
  }

  addProduct(BuildContext context,File? image){
    if(ValidationUtils.emptyValidation(addProductRequest.productTitle!)
        && ValidationUtils.emptyValidation(addProductRequest.category!.toString())
        && ValidationUtils.emptyValidation(addProductRequest.subCategory.toString())
        && ValidationUtils.emptyValidation(addProductRequest.salePrice!.toString())
        && ValidationUtils.emptyValidation(addProductRequest.strikePrice.toString())
        && ValidationUtils.emptyValidation(addProductRequest.quantity!.toString())
        && ValidationUtils.emptyValidation(addProductRequest.unit!.toString())
        && ValidationUtils.emptyValidation(addProductRequest.tax!.toString())
        && ValidationUtils.emptyValidation(addProductRequest.stock!.toString())
        && ValidationUtils.emptyValidation(addProductRequest.description!) && image!=null) {
      Loader.show();
      // double tax = (addProductRequest.salePrice!) * addProductRequest.tax!/100;
      // addProductRequest.tax = int.parse(tax.toStringAsFixed(0));
      apiService.addProduct(image, addProductRequest).then((value) {
        Loader.hide();
        commonModel = value;
        Navigator.pop(context);
      }).catchError((e) {
        Loader.hide();
       // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("All Fields are required.");
    }
  }

  addProductVariant(BuildContext context,File? image, String? id){
    if(ValidationUtils.emptyValidation(addProductVariantRequest.salePrice!.toString())
        && ValidationUtils.emptyValidation(addProductVariantRequest.strikePrice.toString())
        && ValidationUtils.emptyValidation(addProductVariantRequest.quantity!.toString())
        && ValidationUtils.emptyValidation(addProductVariantRequest.unit!.toString())
        && ValidationUtils.emptyValidation(addProductVariantRequest.tax!.toString()) && image!=null) {
      Loader.show();
      // double tax = (addProductVariantRequest.salePrice!) * addProductVariantRequest.tax!/100;
      // addProductVariantRequest.tax = int.parse(tax.toStringAsFixed(0));
      apiService.addProductVariant(image, addProductVariantRequest,id!).then((value) {
        Loader.hide();
        commonModel = value;
        getProductVariant(context, id);
      }).catchError((e) {
        Loader.hide();
       // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("All Fields are required.");
    }
  }

  editProductVariant(BuildContext context,File? image, String? id){
    if(ValidationUtils.emptyValidation(addProductVariantRequest.salePrice!.toString())
        && ValidationUtils.emptyValidation(addProductVariantRequest.strikePrice.toString())
        && ValidationUtils.emptyValidation(addProductVariantRequest.quantity!.toString())
        && ValidationUtils.emptyValidation(addProductVariantRequest.unit!.toString())
        && ValidationUtils.emptyValidation(addProductVariantRequest.tax!.toString())) {
      Loader.show();
      // double tax = (addProductVariantRequest.salePrice!) * addProductVariantRequest.tax!/100;
      // addProductVariantRequest.tax = int.parse(tax.toStringAsFixed(0));
      apiService.editProductVariant(image, addProductVariantRequest,id!).then((value) {
        Loader.hide();
        commonModel = value;
        ValidationUtils.showAppToast("Update Successfully");
        getProductVariant(context, id);
      }).catchError((e) {
        Loader.hide();
      //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("All Fields are required.");
    }
  }

  editItem(BuildContext context,File? image){
    if(ValidationUtils.emptyValidation(addItemRequest.title!)
        && ValidationUtils.emptyValidation(addItemRequest.foodType!)
        && ValidationUtils.emptyValidation(addItemRequest.salePrice!)
        && ValidationUtils.emptyValidation(addItemRequest.quantity!)
        && ValidationUtils.emptyValidation(addItemRequest.tax!)
        && ValidationUtils.emptyValidation(addItemRequest.packingCharge!)) {
      Loader.show();
      // var tax = (double.parse(addItemRequest.salePrice!) * double.parse(addItemRequest.tax!))/100;
      // addItemRequest.tax = tax.toStringAsFixed(0);
      apiService.editItem(image, addItemRequest).then((value) {
        Loader.hide();
        commonModel = value;
        Navigator.pop(context);
      }).catchError((e) {
        Loader.hide();
       // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("All Fields are required.");
    }
  }

  deleteItem(BuildContext context,String productId){
    Loader.show();
    apiService.deleteItem(productId).then((value) {
      Loader.hide();
      commonModel = value;
      getItems(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  statusItem(BuildContext context,String productId,bool status){
    // itemList.clear();
    // menuList.clear();
    Loader.show();
    apiService.statusItem(productId,status).then((value) {
      Loader.hide();
      commonModel = value;
      getItems(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
    //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  addDiscount(BuildContext context,String type,String discount, String minAmount){

    if(ValidationUtils.emptyValidation(discount)) {
      Loader.show();
      if(type == "Flat"){
        type = "1";
      }else{
        type = "2";
      }
      apiService.addDiscount(type, discount,minAmount).then((value) {
        Loader.hide();
        commonModel = value;
        ValidationUtils.showAppToast("Discount Update Successfully");
        notifyListeners();
      }).catchError((e) {
        Loader.hide();
      //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("All Fields are required");
    }
  }

  getDiscount(BuildContext context){
    Loader.show();
    apiService.getDiscount().then((value) {
      Loader.hide();
      setState(() {
        discountModel = value;
        if(discountModel.data!.discountType=="3"){
          discountType = "Select Type";
          discountController.text = discountModel.data!.discount!;
          minOrderController.text = discountModel.data!.upTo!;
        }else if(discountModel.data!.discountType=="2"){
          discountType = "Percentage";
          discountController.text = discountModel.data!.discount!;
          minOrderController.text = discountModel.data!.upTo!;
        }else if(discountModel.data!.discountType=="1"){
          discountType = "Flat";
          discountController.text = discountModel.data!.discount!;
          minOrderController.text = discountModel.data!.upTo!;
        }
      });
      //discountController.text = discountModel.data!.discount!;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
   //   ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  updateFcmToken(BuildContext context,String token){
    Loader.show();
    apiService.updateFcmToken(token).then((value) {
      Loader.hide();
      commonModel = value;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
    //  ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  orderDetailsGetBySaleCode(BuildContext context,String saleCode, FirebaseOrderResponse firebaseOrderResponse){
    Loader.show();
    apiService.orderDetailsGetBySaleCode(saleCode).then((value) {
      Loader.hide();
      playSound();
      notifyListeners();
      orderModel = value;
      if(firebaseOrderResponse.type == "on_track") {
        _showCustomDialog(context, orderModel);
      }
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;

  playSound() async {
    await _audioPlayer.play(AssetSource("sound/alert.mp3"));
    setState(() {
      isPlaying = true;
    });
  }

  stopSound() async {
    await _audioPlayer.stop();
    setState(() {
      isPlaying = false;
    });
  }



  _showCustomDialog(BuildContext context, OrderModel orderModel) async{
    //print("currentPage"+context.widget.runtimeType.toString());
    String? pageName = await PreferenceUtils.getCurrentPage();
    if(pageName!=null) {
      if (pageName.contains("Orders")) {
        return;
      }
    }
    var orderSet = orderModel.data![0];
    var totalAmount = (orderSet.paymentDetails!.subTotal! +orderSet.paymentDetails!.tax!+orderSet.paymentDetails!.packingCharge!) - orderSet.paymentDetails!.vendorDiscount!;
    String? vendorType = await PreferenceUtils.getVendorType();
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          insetPadding: EdgeInsets.all(10),
          child: Container(
            width: double.infinity,
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "New Orders",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                            onTap: (){
                              stopSound();
                            },
                            child: Icon(Icons.close)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      Image.asset(
                        "assets/images/waiting.png",
                        height: 18,
                      ) ,
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Text(
                            "${TimeUtils.getTimeStampToDate(int.parse(orderSet.paymentTimestamp!))}",
                            style: AppStyle.font14MediumBlack87
                                .override(
                                color: Colors.black,
                                fontSize: 8),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "ID:${orderSet.saleCode}",
                                style: AppStyle.font14MediumBlack87
                                    .override(
                                    color: Colors.black,
                                    fontSize: 8,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          children: [
                            ListView.builder(
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: orderSet.productDetails!.length,
                                shrinkWrap: true,
                                itemBuilder: (context, dindex) {
                                  var productBean  = orderSet.productDetails![dindex];

                                  return Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        top: 5),
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            // vendorType == "2" ? Image.asset(
                                            //   "assets/images/non_veg.png",
                                            //   height: 14,
                                            // ):Container(),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              "${productBean.qty}x",
                                              style: AppStyle
                                                  .font14MediumBlack87
                                                  .override(
                                                  color: Colors
                                                      .black,
                                                  fontSize:
                                                  12,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                            SizedBox(
                                              width: 2,
                                            ),
                                            Text(
                                              productBean.productName!,
                                              style: AppStyle
                                                  .font14MediumBlack87
                                                  .override(
                                                  color: Colors
                                                      .black,
                                                  fontSize:
                                                  12,
                                                  fontWeight:
                                                  FontWeight
                                                      .bold),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  );
                                }),
                          ],
                        ),
                      ),
                      Text(
                        ApiConstants.currency+totalAmount.round().toString(),
                        style: AppStyle.font22BoldWhite.override(
                            color: Colors.green, fontSize: 22),
                      )
                    ],
                  ),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment:
                    MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            // Red background color
                            borderRadius: BorderRadius.circular(
                                5), // Rounded corners
                          ),
                          child: Text(
                            'View Details',
                            style: TextStyle(
                              color: Colors
                                  .white, // White text color
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        onTap: () {
                          stopSound();
                          PageNavigation.gotoMobileOrderDetails(
                              context,orderSet);
                        },
                      ),
                      InkWell(
                        onTap: (){
                          stopSound();
                          ordersStatusUpdate(context, orderSet.saleCode!, "on_cancel","All","on_cancel");
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color:
                            Colors.red, // Red background color
                            borderRadius: BorderRadius.circular(
                                5), // Rounded corners
                          ),
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              color:
                              Colors.white, // White text color
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: (){

                          stopSound();
                          _showTimerCustomDialog(context,orderSet.saleCode!,vendorType!);
                        },
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              horizontal: 4, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors
                                .green, // Red background color
                            borderRadius: BorderRadius.circular(
                                5), // Rounded corners
                          ),
                          child: Text(
                            'Accept',
                            style: TextStyle(
                              color:
                              Colors.white, // White text color
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  void _showTimerCustomDialog(BuildContext context, String saleCode, String vendorType) {
    var minController = TextEditingController();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Container(
            height: 300,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  vendorType == "2"  ? Text(
                    'Cooking Time',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ):Text(
                    'Delivery Time',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    width: 60,
                    child: TextField(
                      controller: minController,
                      keyboardType: TextInputType.number,
                      maxLength: 2,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.blue, width: 2.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide(color: Colors.grey, width: 1.0),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10,),
                  Text(
                    'Mins',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold,color: Colors.grey),
                  ),
                  SizedBox(height: 10,),
                  InkWell(
                    onTap: (){
                      if(ValidationUtils.emptyValidation(minController.text)) {
                        setInitialCookingTime(
                            context, saleCode, minController.text,"all");
                        Navigator.pop(context);
                        Navigator.pop(context);
                      }else{
                        vendorType == "2" ? ValidationUtils.showAppToast("Enter Cooking time"):
                        ValidationUtils.showAppToast("Enter Delivery Time");
                      }
                    },
                    child: Container(
                      width: 90,
                      padding: EdgeInsets.symmetric(
                          horizontal: 4, vertical: 4),
                      decoration: BoxDecoration(
                        color:
                        Colors.blue, // Red background color
                        borderRadius: BorderRadius.circular(
                            5), // Rounded corners
                      ),
                      child: Center(
                        child: Text(
                          'Submit',
                          style: TextStyle(
                            color:
                            Colors.white, // White text color
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
        );
      },
    );
  }

  addOnItem(BuildContext context, String? id){
    if(ValidationUtils.emptyValidation(addOnRequest.name!)
        && ValidationUtils.emptyValidation(addOnRequest.salesPrice!)
        && ValidationUtils.emptyValidation(addOnRequest.foodType!)
        && ValidationUtils.emptyValidation(addOnRequest.tax!)
        && ValidationUtils.emptyValidation(addOnRequest.stock!)) {
      Loader.show();
      addOnRequest.productId = id;
      apiService.addOnItem(addOnRequest).then((value) {
        Loader.hide();
        commonModel = value;
        Navigator.pop(context);
      }).catchError((e) {
        Loader.hide();
       // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast("All Fields are required.");
    }
  }

  listAddOnItem(BuildContext context,String productID){
    Loader.show();
    apiService.listAddOnItems(productID).then((value) {
      Loader.hide();
      addOnItemModel = value;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  getDriverDetails(BuildContext context,String id){
    Loader.show();
    apiService.getDriverDetails(id).then((value) {
      Loader.hide();
      driverModel = value;
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  onReady(BuildContext context,String saleCode){
    Loader.show();
    apiService.onReady(saleCode).then((value) {
      Loader.hide();
      if(value.success! == false){
        ValidationUtils.showAppToast(value.message!);
      }
      Navigator.pop(context);
      notifyListeners();
    }).catchError((e) {
      Loader.hide();
     // ValidationUtils.showAppToast(S.of(context, "something_wrong"));
      print(e);
    });
  }

  listOrderChat(String orderId, String type,String sender){
    Loader.show();
    apiService.listOrderChat(orderId,type,sender).then((value){
      Loader.hide();
      if(value.success!){
        setState(() {
          chatResponse = value;
        });
      }else{
      //  ValidationUtils.showAppToast("Something wrong");
      }
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }

  listAdminChat(String type,String sender){
    Loader.show();
    apiService.listAdminChat(type,sender).then((value){
      Loader.hide();
      if(value.success!){
        setState(() {
          chatResponse = value;
        });
      }else{
       // ValidationUtils.showAppToast("Something wrong");
      }
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }

  addOrderChat(ChatRequest chatRequest){
    Loader.show();
    apiService.addOrderChat(chatRequest).then((value){
      Loader.hide();
      if(value.success!){
        listOrderChat(chatRequest.orderId!,chatRequest.type!,chatRequest.sender!);
      }else{
      //  ValidationUtils.showAppToast("Something wrong");
      }
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }

  addAdminChat(ChatRequest chatRequest){
    Loader.show();
    apiService.addAdminChat(chatRequest).then((value){
      Loader.hide();
      if(value.success!){
        listOrderChat(chatRequest.orderId!,chatRequest.type!,chatRequest.sender!);
      }else{
       // ValidationUtils.showAppToast("Something wrong");
      }
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }

  deleteAddOn(BuildContext context,String id, String? productId){
    Loader.show();
    apiService.deleteAddOn(id).then((value){
      Loader.hide();
      listAddOnItem(context, productId!);
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }

  getZoneInformation(){
    Loader.show();
    apiService.getZoneInformation().then((value){
      Loader.hide();
      if(value.success!){
        setState(() {
          zoneInformationModel = value;
        });
      }else{
     //   ValidationUtils.showAppToast("Something wrong");
      }
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }

  getAccountInformation(){
    Loader.show();
    apiService.getAccountInformation().then((value){
      Loader.hide();
      if(value.success!){
        setState(() {
          accountModel = value;
          if(accountModel.data!.opentime!=null && accountModel.data!.closetime!=null) {
            openTimeController.text = accountModel.data!.opentime!;
            closeTimeController.text = accountModel.data!.closetime!;
          }
        });
      }else{
       // ValidationUtils.showAppToast("Something wrong");
      }
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }

  TextEditingController openTimeController = TextEditingController();
  TextEditingController closeTimeController = TextEditingController();

  updateTimings(String openTime,String endTime){
    Loader.show();
    apiService.updateTimings(openTime,endTime).then((value){
      Loader.hide();
      if(value.success!){
        setState(() {
          commonModel = value;
          ValidationUtils.showAppToast("Update Successfully");
        });
      }else{
        //ValidationUtils.showAppToast("Something wrong");
      }
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }


  logout(BuildContext context){
    Loader.show();
    apiService.logout().then((value){
      Loader.hide();
    //  if(value.success!){
        Navigator.pop(context); // Close the drawer
        PageNavigation.goLogout(context);
    }).catchError((e){
      print(e);
      Loader.hide();
    });
  }

}