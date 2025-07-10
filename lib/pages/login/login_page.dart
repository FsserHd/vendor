

import 'package:flutter/cupertino.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/controller/auth_controller.dart';
import 'package:vendor/pages/login/desktop/desktop_login_page.dart';
import 'package:vendor/pages/login/mobile/mobile_login_page.dart';

import '../../responsive/responsive_layout.dart';

class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(mobileBody: MobileLoginPage(), desktopBody: DesktopLoginPage());
  }
}
