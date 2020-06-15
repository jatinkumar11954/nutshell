// import 'package:flutter/material.dart';
// import 'package:nutshell/subscription.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_auth/firebase_auth.dart';


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'global.dart' as global;

// import 'database.dart';
// import 'details.dart';

// class OrderConfirmation extends StatelessWidget {
//   // String subPlan;

//   FirebaseAuth auth = FirebaseAuth.instance;
// void inputData() async {
//     final FirebaseUser user = await auth.currentUser();
//     final uid = user.uid;
//     // here you write the codes to input the data into firestore
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Order Confirmation",style: TextStyle(color:Colors.black),),
//         backgroundColor: Colors.orange[300],
//       ),
//       body: Container(
//           child: Column(
//         children: [
//            Padding(padding: EdgeInsets.all(20)),
//             Padding(padding: EdgeInsets.only(left:15)),
//         // Padding(padding: )
//         //  Text("Order Details",),
//           SizedBox(
//           width: MediaQuery.of(context).size.width - 100,
//           child: Text(
//             "       Order Details",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 30,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.left,
//           ),
//         ),
//          Padding(padding: EdgeInsets.all(10)),
       
//          if (payfree == 1)
//          Text("Price: ₹0\nPlan:FREE includes:\nDuration: 7 days\n No. of paperbacks:2\nIssues:2"),
//           if(payone == 1)
//           Text("Price: ₹69\nPlan:Basic includes:\nDuration: 2 months\n No. of paperbacks:1\nIssues:1"),
//           if (paytwo == 1)
//           Text("Price: ₹56 per issue\nPlan:Standard includes:\nDuration: 6 months\n No. of paperbacks:3\n"),
//           if(paythree== 1)
//           Text("Price: ₹50 per issue\nPlan:Standard includes:\nDuration: 12 months\n No. of paperbacks:6\n"),
//          Container(
//               margin: EdgeInsets.all(20), 
//          child: FlatButton(onPressed:(){
//              if (payone==1) {
//                   print("proceeding to checkout pay1");
//                   global.subPlan="b";
//                   openCheckout();
//                   // print("proceeding to checkout pay1");
//                 }else if (payfree== 1) {
//                   global.subPlan="f";
//                   print("proceeding to checkout payfree");
//                   showAlertDialog(context);
//                   // openCheckoutweek();
//                 } 
//                 else if (paytwo== 1) {
//                   global.subPlan="s";
//                   print("proceeding to checkout pay2");
//                   openCheckoutthree();
//                 } else if (paythree==1) {
//                   global.subPlan="p";
//                   print("proceeding to checkout pay3");
//                   openCheckoutyear();
//                 }
//             //  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
//           } , child: Text("Proceed to checkout"),
//           color: Colors.blueAccent,
//                 textColor: Colors.white, 
//           )
//           )// MaterialButton(onPressed: null)
//         ],
//       )),
      
//     );
//   }
//   // _show(){
//   //   switch (selection1) {
//   //     case  payone == 1 : {
//   //       Text("data");
//   //     }
        
//     //     break;
//     //   default:
//     // }
// // }
// }



// showAlertDialog(BuildContext context) {
//   // set up the buttons
 
//   Widget continueButton = FlatButton(
//     child: Text("Yes"),
//     onPressed: () {
//       //  signOutGoogle();
//                 //  OurDatabase().freesubscription(user.uid);
//                 // OurDatabase().createUser(_currentUser);
//                 CallForFreeUpdation();
//                                 Navigator.of(context)
//                                     .pushNamedAndRemoveUntil('/paperback', (_) => false);},
//                   );
                
//                   // set up the AlertDialog
//                   AlertDialog alert = AlertDialog(
//                     title: Text("Free plan"),
//                     content: Text(" Your free subscription plan ends in 7 days, Continue to Homescreen"),
//                     actions: [
//                       // cancelButton,
//                       continueButton,
//                     ],
//                   );
                
//                   // show the dialog
//                   showDialog(
//                     context: context,
//                     builder: (BuildContext context) {
//                       return alert;
//                     },
//                   );
//                 }
                
// void CallForFreeUpdation() async {

//   try{
// FirebaseUser user = await FirebaseAuth.instance.currentUser();
//   print("current user id");
//   print(user.uid);
  
//    final Firestore fireStore =  Firestore.instance;

//   await fireStore.collection("users").document(user.uid).updateData({
//     "subPlan": global.subPlan,
//     "subscription": true
// });
//     print("updated");

// }
// catch(e){
//   print(e.toString());
// }

// print("account page");
// }





import 'package:flutter/material.dart';
import 'package:nutshell/subscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
 import 'global.dart' as global;

import 'database.dart';
import 'details.dart';

class OrderConfirmation extends StatelessWidget {
  // String subPlan;

  FirebaseAuth auth = FirebaseAuth.instance;
  void inputData() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    // here you write the codes to input the data into firestore
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Order Details",
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.orange[300],
      ),
      body: Container(
          child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(padding: EdgeInsets.all(20)),
          Padding(padding: EdgeInsets.only(left: 400)),
          // Padding(padding: )
          //  Text("Order Details",),
          //   SizedBox(
          //   width: MediaQuery.of(context).size.width - 100,
          //   child: Text(
          //     "       Order Details",
          //     style: TextStyle(
          //       color: Colors.black,
          //       fontSize: 30,
          //       fontWeight: FontWeight.bold,
          //     ),
          //     textAlign: TextAlign.left,
          //   ),
          // ),
          // Padding(padding: EdgeInsets.all(10)),
           ClipRRect(
                    borderRadius: BorderRadius.circular(200.0),
                    child:
                    // _currentUser.photoUrl.toString()=="null"?
                    // Text("No image")
                    // Image.network("https://nofrdz.com/images/l.png")
                    Icon(Icons.check_circle_outline,
                    size:200
                    )
                    // :Image.network(_currentUser.photoUrl.toString())
                    //  Image.asset("assets/images/userimg.png")
                  ),
          if (payfree == 1)
            Text(
              "Price: ₹0\nPlan: FREE \nDuration: 7 days\nNo. of paperbacks:2\n",
              style: TextStyle(fontSize: 20.0,),),
          if (payone == 1)
            Text(
                "Price: ₹69\nPlan: Basic \nDuration: 2 months\nNo. of paperbacks:1\n",style: TextStyle(fontSize: 20.0,),),
                // style: Theme.of(context).textTheme.bodyText1),
          if (paytwo == 1)
            Text(
                "Price: ₹56 per issue\nPlan: Standard \nDuration: 6 months\nNo. of paperbacks:3\n",
                style: TextStyle(fontSize: 20.0,),),
          if (paythree == 1)
            Text(
                "Price: ₹50 per issue\nPlan: Standard \nDuration: 12 months\nNo. of paperbacks:6\n",
                style: TextStyle(fontSize: 20.0,),),
                // TextStyle(fontSize: 20.0),
          // if (payfree == 1)
          //   Text(
          //     "Price: ₹0\nPlan:FREE includes:\nDuration: 7 days\nNo. of paperbacks:2\n",style: TextStyle(fontSize: 20.0,),

          //   ),
          // if (payone == 1)
          //   Text(
          //       "Price: ₹69\nPlan:Basic includes:\nDuration: 2 months\nNo. of paperbacks:1\n",
          //       style: Theme.of(context).textTheme.bodyText1),
          // if (paytwo == 1)
          //   Text(
          //       "Price: ₹56 per issue\nPlan:Standard includes:\nDuration: 6 months\nNo. of paperbacks:3\n",
          //       style: Theme.of(context).textTheme.bodyText1),
          // if (paythree == 1)
          //   Text(
          //       "Price: ₹50 per issue\nPlan:Standard includes:\nDuration: 12 months\nNo. of paperbacks:6\n",
          //       style: Theme.of(context).textTheme.bodyText1),
          Container(
              margin: EdgeInsets.all(20),
              child: FlatButton(
                onPressed: () {
                  if (payone == 1) {
                    print("proceeding to checkout pay1");
                    global.subPlan = "b";
                    openCheckout(context);
                    // print("proceeding to checkout pay1");
                  } else if (payfree == 1) {
                    global.subPlan = "f";
                    print("proceeding to checkout payfree");
                    showAlertDialog(context);
                    // openCheckoutweek();
                  } else if (paytwo == 1) {
                    global.subPlan = "s";
                    print("proceeding to checkout pay2");
                    openCheckoutthree(context);
                  } else if (paythree == 1) {
                    global.subPlan = "p";
                    print("proceeding to checkout pay3");
                    openCheckoutyear(context);
                  }
                  //  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
                },
                child: Text("Proceed to checkout"),
                color: Colors.green,
                textColor: Colors.white,
              )) // MaterialButton(onPressed: null)
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

showAlertDialog(BuildContext context) {
  // set up the buttons

  Widget continueButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      //  signOutGoogle();
      //  OurDatabase().freesubscription(user.uid);
      // OurDatabase().createUser(_currentUser);
      CallForFreeUpdation();
      Navigator.of(context).pushNamedAndRemoveUntil('/paperback', (_) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Free plan"),
    content: Text(
        " Your free subscription plan ends in 7 days, Continue to Homescreen"),
    actions: [
      // cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void CallForFreeUpdation() async {
  try {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    print("current user id");
    print(user.uid);

    final Firestore fireStore = Firestore.instance;

    await fireStore
        .collection("users")
        .document(user.uid)
        .updateData({"subPlan": global.subPlan, "subscription": true});
    print("updated");
  } catch (e) {
    print(e.toString());
  }

  print("account page");
}