

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/constants/app_style.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';

import '../../controller/home_controller.dart';
import '../../flutter_flow/flutter_flow_util.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  _AccountPageState createState() => _AccountPageState();
}

class _AccountPageState extends StateMVC<AccountPage> {

  late HomeController _con;

  _AccountPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }


  DateFormat _dateFormat = DateFormat('HH:mm');

  void _selectDateTime(BuildContext context, String type) async {
    TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectedTime != null) {
      DateTime now = DateTime.now();
      DateTime finalDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        selectedTime.hour,
        selectedTime.minute,
      );

      if (type == "open") {
        _con.openTimeController.text = _dateFormat.format(finalDateTime);
      } else {
        _con.closeTimeController.text = _dateFormat.format(finalDateTime);
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _con.getAccountInformation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10,),
            Text("Bank Information",style: AppStyle.font14MediumBlack87.override(fontSize: 18,color: Colors.black),),
            SizedBox(height: 10,),
            _con.accountModel.data!=null ? Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [

                    Row(
                      children: [
                        Text("Holder Name:",style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                        Text(_con.accountModel.data!.bankDetails!.accountholder!,style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text("Bank Name:",style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                        Text(_con.accountModel.data!.bankDetails!.bankname!,style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text("A/c No:",style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                        Text(_con.accountModel.data!.bankDetails!.accountnumber!,style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text("IFSC:",style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                        Text(_con.accountModel.data!.bankDetails!.ifsc!,style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                      ],
                    ),
                    SizedBox(height: 2,),
                    Row(
                      children: [
                        Text("UPI:",style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                        Text(_con.accountModel.data!.bankDetails!.upiid!,style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
                      ],
                    ),
                  ],
                ),
              ),
            ): Text("No Information found",style: AppStyle.font14MediumBlack87.override(fontSize: 14,color: Colors.black),),
            SizedBox(height: 10,),
            Text("Timings",style: AppStyle.font14MediumBlack87.override(fontSize: 18,color: Colors.black),),
            SizedBox(height: 10,),
            Text("Open Time",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
            InkWell(
              onTap: (){
                _selectDateTime(context,"open");
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _con.openTimeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Open Time',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300, // Light gray border color
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300, // Light gray border color
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.blue, // Blue border color when focused
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 5,),
            Text("Closing Time",style: AppStyle.font14MediumBlack87.override(fontSize: 12),),
            InkWell(
              onTap: (){
                _selectDateTime(context,"close");
              },
              child: AbsorbPointer(
                child: TextFormField(
                  controller: _con.closeTimeController,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    filled: true,
                    fillColor: Colors.white,
                    hintText: 'Close Time',
                    contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300, // Light gray border color
                        width: 1.0,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.grey.shade300, // Light gray border color
                        width: 1.0,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10.0),
                      borderSide: BorderSide(
                        color: Colors.blue, // Blue border color when focused
                        width: 2.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            InkWell(
              onTap: (){
                  _con.updateTimings(_con.openTimeController.text, _con.closeTimeController.text);
              },
              child: Container(
                width: double.infinity,
                height: 40,
                padding: EdgeInsets.symmetric(horizontal: 4, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Center(
                  child: Text(
                    'Submit',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

}
