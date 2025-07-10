

import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:vendor/model/account/account_model.dart';
import 'package:vendor/model/common/common_response_model.dart';
import 'package:vendor/model/dashboard/dashboard_model.dart';
import 'package:vendor/model/discount/discount_model.dart';
import 'package:vendor/model/driver/driver_model.dart';
import 'package:vendor/model/items/add_item_request.dart';
import 'package:vendor/model/items/add_on_request.dart';
import 'package:vendor/model/items/items_model.dart';
import 'package:vendor/model/login/login_model.dart';
import 'package:vendor/model/menu/menu_model.dart';
import 'package:vendor/model/order/order_model.dart';
import 'package:vendor/model/product/add_product_request.dart';
import 'package:vendor/model/product/add_product_variant_request.dart';
import 'package:vendor/model/product/product_model.dart';
import 'package:vendor/model/product/product_variant_model.dart';
import 'package:vendor/model/shop/shop_model.dart';
import 'package:vendor/model/shop/shop_time_model.dart';
import 'package:vendor/model/zone/zone_information_model.dart';
import 'package:vendor/utils/preference_utils.dart';
import 'package:vendor/utils/time_utils.dart';
import '../constants/api_constants.dart';
import '../model/chat/chat_request.dart';
import '../model/chat/chat_response.dart';
import '../model/items/add_on_item_model.dart';
import '../model/subcategory/sub_category_model.dart';
import '../utils/validation_utils.dart';
import 'dio_client.dart';

class ApiService{

  final dioClient = DioClient();

  Future<ShopModel> signIn(LoginModel signInModel) async {
    try {
      final response = await dioClient.post(ApiConstants.login, signInModel.toJson());
      if (response.statusCode == 200) {
        return ShopModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> updateLiveStatus(String status) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.live_status+"/$userId/$status");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> getUserLiveStatus() async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.getUserLiveStatus+"/$userId");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<DashboardModel> getDashBoard() async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.getDashBoard+"/$userId");
      if (response.statusCode == 200) {
        return DashboardModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<OrderModel> getOrders(String s) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.orderDetails+"/$userId/$s");
      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<OrderModel> getPayoutOrders(String s) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.getPayoutOrders+"/$userId/$s");
      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> orderStatusUpdate(String orderId,String status, String s) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      String? zoneId = await PreferenceUtils.getZoneId();
      final response = await dioClient.get(ApiConstants.statusUpdate+"/$orderId/$status/$userId/$zoneId/$s");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> setCookingTime(String orderId, String text) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.setCookingtime+"/$orderId/$text");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<MenuModel> getMenu() async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.category+"$userId");
      if (response.statusCode == 200) {
        return MenuModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<SubCategoryModel> getSubCategory(String? category) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      if(category==null){
        category ="0";
      }
      final response = await dioClient.get(ApiConstants.subcategory+"$userId/$category");
      if (response.statusCode == 200) {
        return SubCategoryModel.fromJson(response.data);
      } else {
        //ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
     // //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<ProductModel> getProducts() async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.products+"$userId");
      if (response.statusCode == 200) {
        return ProductModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<ProductVariantModel> getProductVariant(String productId) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.variantProducts+"$productId/null/$userId");
      if (response.statusCode == 200) {
        return ProductVariantModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addMenu(String category,File? image) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path, filename: '${TimeUtils.getTimestamp()}upload.jpg'),
      'categoryName': category,
      'vendor': userId,
    });

    try {
      Response response = await _dio.post(ApiConstants.addMenu, data: formData);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addSuCategoryMenu(String category,File? image, String categoryId) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path, filename: '${TimeUtils.getTimestamp()}upload.jpg'),
      'sub_category_name': category,
      'category': categoryId,
      'vendor': userId,
      'status': "1",
    });

    try {
      Response response = await _dio.post(ApiConstants.addSubcategory+userId!, data: formData);
      print(ApiConstants.addSubcategory+userId!);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> editMenu(String category,File? image, String? id) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path, filename: '${TimeUtils.getTimestamp()}upload.jpg'),
      'categoryName': category,
      'vendor': userId,
    });
    print(ApiConstants.editMenu+id!+"/null");
    try {
      Response response = await _dio.post(ApiConstants.editMenu+id!+"/null", data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> editSubCategory(String subCategory,File? image, String? id, String category) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path, filename: '${TimeUtils.getTimestamp()}upload.jpg'),
      'sub_category_name': category,
      'category': category,
      'vendor': userId,
    });
    print(ApiConstants.editMenu+id!+"/null");
    try {
      Response response = await _dio.post(ApiConstants.editSubCategory+id!+"/$userId", data: formData);
      if (response.statusCode == 200) {
        print(response.data);
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> deleteMenu(String catId) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.deleteMenu+"/$catId");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> deleteProduct(String productId) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.deleteProduct+"/$productId");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> deleteVariant(String productId) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.variantDelete+"/$productId");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> deleteSubCategory(String catId) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.deleteSubCategory+"/$catId");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> statusMenu(String catId,String status) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.statusMenu+"/$catId/$status");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> productStatus(String catId,String status) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.productStatus+"$catId/$status/$userId");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> statusSubCategory(String catId,String status) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.statusSubCategory+"/$catId/$status");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<ItemModel> getItems() async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.getItems+"/$userId");
      if (response.statusCode == 200) {
        return ItemModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addItem(File? image,AddItemRequest request) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path, filename: '${TimeUtils.getTimestamp()}upload.jpg'),
      'category': request.category,
      'productTitle': request.title,
      'fromTime': "12:00 AM",
      'toTime':  "12:00 AM",
      'description': request.description,
      'quantity': request.quantity,
      'unit': request.quantity,
      'salePrice': request.salePrice,
      'strikePrice': request.salePrice,
      'vendor': userId,
      'tax':request.tax,
      'foodType': request.foodType,
      'packingCharge': request.packingCharge,
    });
    print({
      'category': request.category,
      'productTitle': request.title,
      'fromTime': "12:00 AM",
      'toTime':  "12:00 AM",
      'description': request.description,
      'quantity': request.quantity,
      'unit': request.quantity,
      'salePrice': request.salePrice,
      'strikePrice': request.salePrice,
      'vendor': userId,
      'foodType': request.foodType,
      'packingCharge': request.packingCharge,
    });
    try {
      Response response = await _dio.post(ApiConstants.addItems, data: formData);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addProduct(File? image,AddProductRequest request) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path, filename: '${TimeUtils.getTimestamp()}upload.jpg'),
      'productTitle': request.productTitle,
      'category': request.category,
      'salePrice': request.salePrice,
      'tax':  request.tax,
      'discount': request.discount,
      'quantity': request.quantity,
      'description': request.description,
      'vendor': userId,
      'subCategory': request.subCategory,
      'strikePrice': request.strikePrice,
      'unit': request.unit,
      'stock': request.stock,
    });

    try {
      Response response = await _dio.post(ApiConstants.addProduct+"$userId", data: formData);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addProductVariant(File? image,AddProductVariantRequest request,String productId) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    FormData formData = FormData.fromMap({
      'image': await MultipartFile.fromFile(image!.path, filename: '${TimeUtils.getTimestamp()}upload.jpg'),
      'variant_id': request.variantId,
      'salePrice': request.salePrice,
      'strikePrice': request.strikePrice,
      'quantity':  request.quantity,
      'unit': request.unit,
      'vendor': userId,
      'foodType': "no_type",
      'tax': request.tax,
      'discount': request.discount,
    });

    try {
      Response response = await _dio.post(ApiConstants.varianAdd+"$productId/3/$userId", data: formData);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> editProductVariant(File? image,AddProductVariantRequest request,String variantId) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    FormData formData = FormData.fromMap({
      'variant_id': request.variantId,
      'salePrice': request.salePrice,
      'strikePrice': request.strikePrice,
      'quantity':  request.quantity,
      'unit': request.unit,
      'vendor': userId,
      'foodType': "no_type",
      'tax': request.tax,
      'discount': request.discount,
    });

    try {
      Response response = await _dio.post(ApiConstants.variantEdit+"${variantId}/3/$userId", data: formData);
      print(ApiConstants.variantEdit+"${request.variantId}/3/$userId");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> editItem(File? image,AddItemRequest request) async {
    final _dio = Dio();
    String? userId = await PreferenceUtils.getUserId();
    var formData;
    if(image!=null){
      formData = FormData.fromMap({
        'image': await MultipartFile.fromFile(image!.path, filename: '${TimeUtils.getTimestamp()}upload.jpg'),
        'productTitle': request.title,
        'quantity': request.quantity,
        'unit': request.quantity,
        'salePrice': request.salePrice,
        'tax': request.tax,
        'foodType': request.foodType,
        'packingCharge': request.packingCharge,
        'variant_id': request.varientId,
        'productId': request.productId,
      });
    }else{
      formData = FormData.fromMap({
        'productTitle': request.title,
        'quantity': request.quantity,
        'unit': request.quantity,
        'salePrice': request.salePrice,
        'tax': request.tax,
        'foodType': request.foodType,
        'packingCharge': request.packingCharge,
        'variant_id': request.varientId,
        'productId': request.productId,
      });
    }
    print({
      'productTitle': request.title,
      'quantity': request.quantity,
      'unit': request.quantity,
      'salePrice': request.salePrice,
      'tax': request.tax,
      'foodType': request.foodType,
      'packingCharge': request.packingCharge,
      'variant_id': request.varientId,
      'productId': request.productId,
    });
    try {
      Response response = await _dio.post(ApiConstants.editItems, data: formData);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> deleteItem(String productId) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.deleteItem+"/$productId");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }


  Future<CommonResponseModel> statusItem(String productId,bool status) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.statusItem+"/$productId/$status");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addDiscount(String type,String discount, String minAmount) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.addDiscount+"/$userId/$type/$discount/$minAmount");
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<DiscountModel> getDiscount() async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.getVendorDiscount+"/$userId");
      if (response.statusCode == 200) {
        return DiscountModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> updateFcmToken(String token) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      var data = {
        "fcmtoken":token,
        "vendor_id":userId
      };
      final response = await dioClient.post(ApiConstants.updateFcmtoken,json.encode(data));
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<OrderModel> orderDetailsGetBySaleCode(String saleCode) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.Orderdetailsbysalecode+saleCode);
      if (response.statusCode == 200) {
        return OrderModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addOnItem(AddOnRequest request) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      request.vendorId = userId;
      final response = await dioClient.post(ApiConstants.addAddon,request.toJson());
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<AddOnItemModel> listAddOnItems(String productId) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.listAddon+productId);
      if (response.statusCode == 200) {
        return AddOnItemModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }


  Future<DriverModel> getDriverDetails(String driverId) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.getDriverDetails+driverId);
      if (response.statusCode == 200) {
        return DriverModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> onReady(String salecode) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(ApiConstants.changesalereadyStatus+salecode);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
       // ValidationUtils.showAppToast('Failed to sign in. Status code: ${response.statusCode}');
        throw Exception('Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<ChatResponse> listOrderChat(String orderId, String type, String sender) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(
          ApiConstants.listChat+'$orderId/$type/$sender');
      if (response.statusCode == 200) {
        return ChatResponse.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<ChatResponse> listAdminChat(String type, String sender) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(
          ApiConstants.listChat+'$userId/$type/$sender');
      if (response.statusCode == 200) {
        return ChatResponse.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addOrderChat(ChatRequest request) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.post(
          ApiConstants.addChat, request.toJson());
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> addAdminChat(ChatRequest request) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.post(
          ApiConstants.addChat, request.toJson());
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> deleteAddOn(String id) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(
          ApiConstants.deleteAddOn+id);
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<ZoneInformationModel> getZoneInformation() async {
    try {
      String? zoneId = await PreferenceUtils.getZoneId();
      final response = await dioClient.get(
          ApiConstants.getZoneInformation+'$zoneId');
      if (response.statusCode == 200) {
        return ZoneInformationModel.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<AccountModel> getAccountInformation() async {
    try {
      String? zoneId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(
          ApiConstants.getProfile+'$zoneId');
      if (response.statusCode == 200) {
        return AccountModel.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> updateTimings(String openTime, String endTime) async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      var requet = ShopTimeModel();
      requet.opentime = openTime;
      requet.closetime = endTime;
      final response = await dioClient.post(
          ApiConstants.updateTimings+'$userId',requet.toJson());
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

  Future<CommonResponseModel> logout() async {
    try {
      String? userId = await PreferenceUtils.getUserId();
      final response = await dioClient.get(
          ApiConstants.logOut+'$userId');
      if (response.statusCode == 200) {
        return CommonResponseModel.fromJson(response.data);
      } else {
        // ValidationUtils.showAppToast(
        //     'Failed to sign in. Status code: ${response.statusCode}');
        throw Exception(
            'Failed to sign in. Status code: ${response.statusCode}');
      }
    } catch (e) {
      //ValidationUtils.showAppToast('Error during sign in: $e');
      print('Error during sign in: $e');
      throw e;
    }
  }

}

final apiServiceProvider = Provider<ApiService>((ref)=>ApiService());