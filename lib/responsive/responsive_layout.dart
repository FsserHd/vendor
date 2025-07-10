

import 'package:flutter/cupertino.dart';

import '../dimensions/display_dimensions.dart';


class ResponsiveLayout extends StatelessWidget {
  final Widget mobileBody;
  final Widget desktopBody;

  const ResponsiveLayout({Key? key, required this.mobileBody, required this.desktopBody}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  LayoutBuilder(builder: (builder,constraints){
        if(constraints.maxWidth <mobileWidth){
          return mobileBody;
        }else{
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(width:800,child: mobileBody),
            ],
          );
        }
      }
    );
  }
}
