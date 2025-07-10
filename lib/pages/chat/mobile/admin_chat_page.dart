import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';
import 'package:vendor/utils/preference_utils.dart';

import '../../../constants/app_style.dart';
import '../../../controller/home_controller.dart';
import '../../../utils/time_utils.dart';

class AdminChatPage extends StatefulWidget {
  const AdminChatPage({super.key});

  @override
  _AdminChatPageState createState() => _AdminChatPageState();
}

class _AdminChatPageState extends StateMVC<AdminChatPage> {

  late HomeController _con;

  _AdminChatPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }


  TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.listAdminChat("admin","vendor");
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child:  _con.chatResponse.data!=null ? ListView.builder(itemCount: _con.chatResponse.data!.length,shrinkWrap: true,itemBuilder: (context,index){
            var chatBean = _con.chatResponse.data![index];
            return   chatBean.type!="vendor" ?  ListTile(
              title: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(chatBean.message!,style: AppStyle.font14MediumBlack87.override(color: Colors.white)),
                      Text(TimeUtils.convertMonthDateYear(chatBean.createdAt!),style: AppStyle.font14MediumBlack87.override(color: Colors.white)),

                    ],
                  ),
                ),
              ),
            ): ListTile(
              title: Align(
                alignment: Alignment.centerLeft,
                child: Container(
                  padding: EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.blue[300],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      Text(chatBean.message!,style: AppStyle.font14MediumBlack87.override(color: Colors.white)),
                      Text(TimeUtils.convertMonthDateYear(chatBean.createdAt!),style: AppStyle.font14MediumBlack87.override(color: Colors.white)),

                    ],
                  ),
                ),
              ),
            );
          }):Container(),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.grey[200],
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: 'Type your message...',
                  ),
                ),
              ),
              SizedBox(width: 8),
              CircleAvatar(
                backgroundColor: Colors.blue,
                child: IconButton(
                  icon: Icon(Icons.send, color: Colors.white),
                  onPressed: () async {
                    // Handle send message action
                    String message = _messageController.text;
                    if (message.isNotEmpty) {
                      // Add the message to your chat logic here
                      _messageController.clear();
                    }
                    String? userId = await PreferenceUtils.getUserId();
                    _con.chatRequest.orderId = userId;
                    _con.chatRequest.message =message;
                    _con.chatRequest.type = "admin";
                    _con.chatRequest.sender = "vendor";
                    _con.addAdminChat(_con.chatRequest);
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
