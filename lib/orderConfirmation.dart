import 'package:flutter/material.dart';
import 'package:nutshell/subscription.dart';

class OrderConfirmation extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      body: Container(
          child: Column(
        children: [
         Text("Order Details", style: Theme.of(context).textTheme.headline2,),
         if (payfree == 1)
         Text("data"),
          if(payone == 1)
          Text("1"),
          if (paytwo == 1)
          Text("2"),
          if(paythree== 1)
          Text("3"),

          MaterialButton(onPressed: null)
        ],
      )),
      
    );
  }
  // _show(){
  //   switch (selection1) {
  //     case  payone == 1 : {
  //       Text("data");
  //     }
        
    //     break;
    //   default:
    // }
// }
}
