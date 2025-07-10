import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';

import '../../../constants/app_style.dart';
import '../../../controller/home_controller.dart';

class MobileContactUs extends StatefulWidget {
  const MobileContactUs({super.key});

  @override
  _MobileContactUsState createState() => _MobileContactUsState();
}

class _MobileContactUsState extends StateMVC<MobileContactUs> {

  late HomeController _con;

  _MobileContactUsState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getZoneInformation();
  }

  void _openWhatsApp(String mobileNumber) async {
    final url = 'https://wa.me/$mobileNumber';
   // if (await canLaunch(url)) {
      await launch(url);
   // } else {
    //  throw 'Could not launch WhatsApp.';
   // }
  }

  void launchEmail({required String toEmail, required String subject, required String body}) async {
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: toEmail,
      queryParameters: {
        'subject': subject,
        'body': body,
      },
    );

   // if (await canLaunch(emailLaunchUri.toString())) {
      await launch(emailLaunchUri.toString());
    // } else {
    //   throw 'Could not launch $emailLaunchUri';
    // }
  }
  
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text("Support",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: () async {
                      await FlutterPhoneDirectCaller.callNumber(_con.zoneInformationModel.data![0].phone!);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/call.png"),
                            Text("Call",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: InkWell(
                    onTap: () async {
                     _openWhatsApp("+91"+_con.zoneInformationModel.data![0].phone!);
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/whatsapp.png"),
                            Text("Message",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    onTap: (){
                      launchEmail(toEmail:_con.zoneInformationModel.data![0].email!,subject:"Content",body:"Hi there!");
                    },
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset("assets/images/gmail.png"),
                            Text("Email",style: AppStyle.font22BoldWhite.override(color: Colors.black,fontSize: 20),),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ],
        ),
      ),
    );
  }
}
