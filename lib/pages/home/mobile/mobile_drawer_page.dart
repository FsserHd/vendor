

import 'package:flutter/cupertino.dart';
import 'package:vendor/pages/account/account_page.dart';
import 'package:vendor/pages/chat/mobile/admin_chat_page.dart';
import 'package:vendor/pages/chat/mobile/mobile_chat_page.dart';
import 'package:vendor/pages/contact/mobile/mobile_contact_us.dart';
import 'package:vendor/pages/dashboard/mobile/mobile_dashboard_page.dart';
import 'package:vendor/pages/discount/mobile/mobile_discount_page.dart';
import 'package:vendor/pages/grocery/category_page.dart';
import 'package:vendor/pages/grocery/product_page.dart';
import 'package:vendor/pages/grocery/sub_category_page.dart';
import 'package:vendor/pages/items/mobile/mobile_item_page.dart';
import 'package:vendor/pages/menu/mobile/mobile_menu_page.dart';
import 'package:vendor/pages/orders/mobile/mobile_order_page.dart';
import 'package:vendor/pages/payouts/mobile/mobile_payout_page.dart';
import 'package:vendor/pages/reviews/mobile/mobile_review_page.dart';

class MobileDrawerPage extends StatefulWidget {
  String currentPage;
  MobileDrawerPage(this.currentPage, {super.key});

  @override
  State<MobileDrawerPage> createState() => _MobileDrawerPageState();
}

class _MobileDrawerPageState extends State<MobileDrawerPage> {
  @override
  Widget build(BuildContext context) {
    print(widget.currentPage);
    switch (widget.currentPage) {
      case "Home":
        return const MobileDashboardPage();
      case "Orders":
        return const MobileOrderPage();
      case "Chat":
        return AdminChatPage();
      case "Contact":
        return const MobileContactUs();
      case "Category":
        return const CategoryPage();
      case "Sub Category":
        return const SubCategoryPage();
      case "Products":
        return const ProductPage();
      case "Menu":
        return const MobileMenuPage();
      case "Items":
        return const MobileItemPage();
      case "Discounts":
        return const MobileDiscountPage();
      case "Finance":
        return const MobilePayoutPage();
      case "Account":
        return const AccountPage();
      default:
        return const SizedBox(); // Default widget
    }
  }
}
