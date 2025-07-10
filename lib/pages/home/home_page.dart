

import 'package:flutter/cupertino.dart';
import 'package:vendor/pages/home/desktop/desktop_home_page.dart';
import 'package:vendor/pages/home/mobile/mobile_home_page.dart';

import '../../responsive/responsive_layout.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(mobileBody: MobileHomePage(), desktopBody: DesktopHomePage());
  }
}
