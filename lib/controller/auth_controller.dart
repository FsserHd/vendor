

import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/model/login/login_model.dart';
import 'package:vendor/navigation/page_navigation.dart';
import 'package:vendor/utils/loader.dart';
import 'package:vendor/utils/preference_utils.dart';
import 'package:vendor/utils/validation_utils.dart';

import '../constants/lang.dart';
import '../network/api_service.dart';

class AuthController extends ControllerMVC{

  final GlobalKey<FormState> loginKey = GlobalKey<FormState>();
  var loginModel = LoginModel();

  //Network Service
  ApiService apiService = ApiService();

  login(BuildContext context){
    if(ValidationUtils.emptyValidation(loginModel.email!) && ValidationUtils.emptyValidation(loginModel.password!)) {
      Loader.show();
      apiService.signIn(loginModel).then((value) {
        Loader.hide();
        if(value.success!){
          PreferenceUtils.saveUserId(value.data!.id!);
          PreferenceUtils.saveVendorType(value.data!.type.toString());
          PageNavigation.gotoHomePage(context);
        }else{
          ValidationUtils.showAppToast(S.of(context, "login_wrong_input"));
        }
      }).catchError((e) {
        Loader.hide();
        ValidationUtils.showAppToast(S.of(context, "something_wrong"));
        print(e);
      });
    }else{
      ValidationUtils.showAppToast(S.of(context, "login_error"));
    }
  }

}