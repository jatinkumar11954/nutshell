import 'package:flutter/material.dart';
import 'package:nutshell/subscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'database.dart';
import 'details.dart';

class OrderConfirmation extends StatelessWidget {

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
        title: Text("Order Confirmation",style: TextStyle(color:Colors.black),),
        backgroundColor: Colors.orange[300],
      ),
      body: Container(
          child: Column(
        children: [
           Padding(padding: EdgeInsets.all(20)),
            Padding(padding: EdgeInsets.only(left:15)),
        // Padding(padding: )
        //  Text("Order Details",),
          SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            "       Order Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
         Padding(padding: EdgeInsets.all(10)),
       
         if (payfree == 1)
         Text("Price: ₹0\nPlan:FREE includes:\nDuration: 7 days\n No. of paperbacks:2\nIssues:2"),
          if(payone == 1)
          Text("Price: ₹69\nPlan:Basic includes:\nDuration: 2 months\n No. of paperbacks:1\nIssues:1"),
          if (paytwo == 1)
          Text("Price: ₹56 per issue\nPlan:Standard includes:\nDuration: 6 months\n No. of paperbacks:3\n"),
          if(paythree== 1)
          Text("Price: ₹50 per issue\nPlan:Standard includes:\nDuration: 12 months\n No. of paperbacks:6\n"),
         Container(
              margin: EdgeInsets.all(20), 
         child: FlatButton(onPressed:(){
             if (payone==1) {
                  print("proceeding to checkout pay1");

                  openCheckout();
                  // print("proceeding to checkout pay1");
                }else if (payfree== 1) {
                  
                  print("proceeding to checkout payfree");
                  showAlertDialog(context);
                  // openCheckoutweek();
                } 
                else if (paytwo== 1) {
                  
                  print("proceeding to checkout pay2");
                  openCheckoutthree();
                } else if (paythree==1) {
                  
                  print("proceeding to checkout pay3");
                  openCheckoutyear();
                }
            //  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
          } , child: Text("Proceed to checkout"),
          color: Colors.blueAccent,
                textColor: Colors.white, 
          )
          )// MaterialButton(onPressed: null)
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
                
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/home', (_) => false);},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Free plan"),
    content: Text(" Your free subscription plan ends in 7 days, Continue to Homescreen"),
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
