

import 'package:flutter/cupertino.dart';
import 'package:vendor/pages/home/desktop/desktop_drawer_page.dart';
import 'package:vendor/pages/home/mobile/mobile_drawer_page.dart';

import '../../responsive/responsive_layout.dart';

class DrawerPage extends StatefulWidget {
  String currentPage;

  DrawerPage(this.currentPage, {super.key});

  @override
  State<DrawerPage> createState() => _DrawerPageState();
}

class _DrawerPageState extends State<DrawerPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileBody: MobileDrawerPage(widget.currentPage), desktopBody: DesktopDrawerPage(widget.currentPage));
  }
}
