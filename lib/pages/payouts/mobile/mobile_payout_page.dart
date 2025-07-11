

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:vendor/constants/api_constants.dart';
import 'package:vendor/constants/app_colors.dart';
import 'package:vendor/constants/app_style.dart';
import 'package:vendor/flutter_flow/flutter_flow_theme.dart';
import 'package:vendor/navigation/page_navigation.dart';
import 'package:vendor/utils/time_utils.dart';

import '../../../controller/home_controller.dart';

class MobilePayoutPage extends StatefulWidget {

  const MobilePayoutPage({super.key});

  @override
  _MobilePayoutPageState createState() => _MobilePayoutPageState();
}

class _MobilePayoutPageState extends StateMVC<MobilePayoutPage> {

  late HomeController _con;

  _MobilePayoutPageState() : super(HomeController()) {
    _con = controller as HomeController;
  }

  TextEditingController searchController = TextEditingController();
  List<Map<String, String>> data = [
    {'id': '1', 'name': 'John Doe', 'mobile': '1234567890'},
    {'id': '2', 'name': 'Jane Smith', 'mobile': '0987654321'},
    {'id': '3', 'name': 'Mike Johnson', 'mobile': '5555555555'},
    {'id': '4', 'name': 'Emily Davis', 'mobile': '4444444444'},
  ];

  List<Map<String, String>> filteredData = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    filteredData = data;
    _con.getPayoutOrders(context, "all");
  }

  void filterSearch(String query) {
    // List<Map<String, String>> filtered = _con.orderModel.data
    //     .where((item) => item['name']!.toLowerCase().contains(query.toLowerCase()) ||
    //     item['mobile']!.toLowerCase().contains(query.toLowerCase()) ||
    //     item['id']!.toLowerCase().contains(query.toLowerCase()))
    //     .toList();
    // setState(() {
    //   filteredData = filtered;
    // });
  }

  String _selectedItem = 'All';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.dashboardBgColor,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 16),
              decoration: BoxDecoration(
                color: Colors.white, // Light gray background color
                borderRadius: BorderRadius.circular(10), // Rounded corners
                border: Border.all(color: Colors.grey.shade300), // Border color
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _selectedItem,
                  icon: Icon(Icons.arrow_drop_down),
                  iconSize: 24,
                  elevation: 16,
                  style: TextStyle(color: Colors.black, fontSize: 16),
                  onChanged: (String? newValue) {
                    if(newValue == "Pending"){
                      _con.getPayoutOrders(context, "pending");
                    }else if(newValue == "Completed"){
                      _con.getPayoutOrders(context, "completed");
                    }else{
                      _con.getPayoutOrders(context, "all");
                    }

                  },
                  items: <String>[
                    'All',
                    'Pending',
                    "Completed"
                  ].map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text(value),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
            SizedBox(height: 20),
            // Container(
            //   height: 50,
            //   child: TextField(
            //     controller: searchController,
            //     decoration: InputDecoration(
            //       hintText: 'Search',
            //       prefixIcon: Icon(Icons.search),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(10.0),
            //       ),
            //     ),
            //     onChanged: (value) {
            //       filterSearch(value);
            //     },
            //   ),
            // ),
            // SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("S.No",style: AppStyle.font14MediumBlack87.override(color: Colors.black)),
                Text("OrderID",style: AppStyle.font14MediumBlack87.override(color: Colors.black)),
                Text("Details",style: AppStyle.font14MediumBlack87.override(color: Colors.black)),
              ],
            ),
            Expanded(
              child: _con.orderModel.data!=null ? ListView.builder(
                itemCount: _con.orderModel.data!.length,
                itemBuilder: (context, index) {
                  var item = _con.orderModel.data![index];
                  var addTotal = item.addonDetails?.fold(0, (sum, item) => sum! + (int.parse(item.price!) * item.qty!)) ?? 0;
                  var totalAmount = (item.paymentDetails!.subTotal! +item.paymentDetails!.tax! + item.paymentDetails!.packingCharge! + addTotal) - item.paymentDetails!.vendorDiscount!;
                  var commission = 0.0;
                  item.productDetails!.forEach((element) {
                    commission += (double.parse(element.price!)  - double.parse(element.strike!)) * element.qty!;
                  });
                  return Card(
                    elevation: 2.0,
                    margin: EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: Text((index+1).toString()),
                      title: Text(item.saleCode!,style: AppStyle.font14MediumBlack87.override(color: Colors.black)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(ApiConstants.currency+(totalAmount - commission).round().toString(),style: AppStyle.font14MediumBlack87.override(color: Colors.green),),
                              SizedBox(width: 10,),
                              item.settlement! == "pending" ? Text("Pending",style: AppStyle.font14MediumBlack87.override(color: Colors.red)):
                              Text("Completed",style: AppStyle.font14MediumBlack87.override(color: Colors.green))
                            ],
                          ),
                          item.settlement! == "pending" ? Container() :Text("Transaction Id: ${item.transcationid}",style: AppStyle.font14MediumBlack87.override(color: Colors.grey),),
                          Text(TimeUtils.getTimeStampToDate(int.parse(item.paymentTimestamp!)),style: AppStyle.font14MediumBlack87.override(color: Colors.grey),),
                        ],
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.remove_red_eye),
                        onPressed: () {
                          // Handle edit action
                          PageNavigation.gotoMobileOrderDetails(context, item);
                        },
                      ),
                    ),
                  );
                },
              ):Container()
            ),
          ],
        ),
      ),
    );
  }
}
