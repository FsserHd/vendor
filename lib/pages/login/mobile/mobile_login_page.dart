

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/constants/app_colors.dart';
import 'package:vendor/constants/app_style.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';

import '../../../constants/lang.dart';
import '../../../controller/auth_controller.dart';
import '../../../language/app_localizations.dart';

class MobileLoginPage extends StatefulWidget {

  const MobileLoginPage({super.key});

  @override
  _MobileLoginPageState createState() => _MobileLoginPageState();
}

class _MobileLoginPageState extends StateMVC<MobileLoginPage> {

  late AuthController _con;

  _MobileLoginPageState() : super(AuthController()) {
    _con = controller as AuthController;
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.themeColor, Colors.white],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Welcome",style: AppStyle.font22BoldWhite,),
                SizedBox(height: 10,),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(16.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        blurRadius: 6.0,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Form(
                    key: _con.loginKey,
                    child: Column(
                      children: [
                        TextFormField(
                          onSaved: (value){
                            _con.loginModel.email = value;
                          },
                          style: AppStyle.font14MediumBlack87,
                          keyboardType: TextInputType.emailAddress,
                          validator: (input) => !input!.contains('@')
                              ? AppLocalizations.of(context).translate('email_error')
                              : null,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('email_hint'),
                            labelText: AppLocalizations.of(context).translate('email_label'),
                            suffixIcon: Icon(
                              Icons.mail_outline,
                            ),
                          ),
                        ),
                        SizedBox(height: 10,),
                        TextFormField(
                          obscureText: true,
                          onSaved: (value){
                            _con.loginModel.password = value;
                          },
                          style: AppStyle.font14MediumBlack87,
                          keyboardType: TextInputType.text,
                          validator: (input) =>
                          input!.length <= 1 ? AppLocalizations.of(context).translate('password_error') : null,
                          decoration: InputDecoration(
                            hintText: AppLocalizations.of(context).translate('password_hint'),
                            labelText: AppLocalizations.of(context).translate('password_label'),
                            suffixIcon: Icon(
                              Icons.password,
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                      /*  Align(alignment: Alignment.bottomRight,child: Text("Forget Password",style: AppStyle.font18BoldWhite.override(fontSize: 16,color: AppColors.themeColor),)),
                        SizedBox(height: 20,),*/
                        InkWell(
                          onTap: () {
                            FocusManager.instance.primaryFocus?.unfocus();
                            _con.loginKey.currentState!.save();
                            _con.login(context);
                          },
                          child: Container(
                            height: 50,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: AppColors.themeColor,
                              borderRadius: BorderRadius.all(
                                Radius.circular(25),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.themeColor,
                                  spreadRadius: 4,
                                  blurRadius: 7,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Center(
                              child: Text(
                                S.of(context, "login"),
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20,),
                        // Row(
                        //   mainAxisAlignment: MainAxisAlignment.center,
                        //   children: [
                        //     Text("Create an account",style: AppStyle.font18BoldWhite.override(fontSize: 16,color: AppColors.themeColor),),
                        //     Icon(
                        //       Icons.arrow_right,
                        //       color: AppColors.themeColor,
                        //       size: 22,
                        //     )
                        //   ],
                        // ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
