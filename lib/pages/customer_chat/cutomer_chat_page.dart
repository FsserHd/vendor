

import 'package:flutter/cupertino.dart';
import 'package:vendor/pages/customer_chat/mobile/mobile_customer_chat_page.dart';

import '../../responsive/responsive_layout.dart';

class CustomerChatPage extends StatefulWidget {
  const CustomerChatPage({super.key});

  @override
  State<CustomerChatPage> createState() => _CustomerChatPageState();
}

class _CustomerChatPageState extends State<CustomerChatPage> {
  @override
  Widget build(BuildContext context) {
    return const ResponsiveLayout(mobileBody: MobileCustomerChatPage(), desktopBody: MobileCustomerChatPage());
  }
}
