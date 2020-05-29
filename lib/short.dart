import 'package:flutter/widgets.dart';
class SizeConfig {
 static MediaQueryData _mediaQueryData;
 static double screenWidth;
 static double screenHeight;
 static double blockSizeHorizontal;
 static double blockSizeVertical;
  static double h, w;
 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData.size.width;
  screenHeight = _mediaQueryData.size.height;
  blockSizeHorizontal = screenWidth / 100;
  blockSizeVertical = screenHeight / 100;
 }
 void find(BuildContext context) {
    h = (MediaQuery.of(context).size.height);
    w = (MediaQuery.of(context).size.width);
  }
}