

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_colors.dart';
import '../../../constants/app_style.dart';

class MobileCustomerChatPage extends StatefulWidget {
  const MobileCustomerChatPage({super.key});

  @override
  State<MobileCustomerChatPage> createState() => _MobileCustomerChatPageState();
}

class _MobileCustomerChatPageState extends State<MobileCustomerChatPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.themeColor,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Chat",style: TextStyle(color: Colors.white,fontFamily: AppStyle.robotoRegular),),
          centerTitle: true,
        ),
        body: Stack(
          children: [
            ListView.builder(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(10.0),
                            bottomLeft: Radius.circular(0.0),
                            topRight: Radius.circular(10.0),
                            bottomRight: Radius.circular(10.0),
                          ),
                          border: Border.all(
                            color: Colors.grey, // Border color
                            width: 1.0,         // Border width
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "Hello",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0), // Adjust the border radius as needed
                            color: Colors.grey[200], // Gray fill color
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter text here',
                              contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10,),
                      Icon(Icons.send,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
