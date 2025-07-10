

import 'package:flutter/cupertino.dart';
import 'package:vendor/pages/chat/desktop/desktop_chat_page.dart';
import 'package:vendor/pages/chat/mobile/mobile_chat_page.dart';

import '../../responsive/responsive_layout.dart';

class ChatPage extends StatefulWidget {
  String s;
  String type;
   ChatPage(this.s, this.type, String sender, {super.key});

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(mobileBody: MobileChatPage(widget.s,widget.type), desktopBody: DesktopChatPage());
  }
}
