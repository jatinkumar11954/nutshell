import 'package:flutter/material.dart';
import 'package:nutshell/subscription.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'global.dart' as global;

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
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
             padding: EdgeInsets.only(
                left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children:<Widget> [
           
                Text(
                  'Thank You for your order!',
                  style: TextStyle(
                      fontSize: 75.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent[700]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.04,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Order ID:',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        '45...',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Subscription type:',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                      ),
                      Text(
                          payfree==1?"Free":payone==1?"Basic":paytwo==1?"Standard":paythree==1?"Premium":"Error",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Valid till:',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                      ),
                      Text(
                        payfree==1?"7 Days":payone==1?"30 Days":paytwo==1?"6 Months":paythree==1?"! year":"Error",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                Divider(
                  thickness: 2.0,
                  color: Colors.black,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.01,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.80,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        'Subtotal:',
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                      ),
                      Text(
                       payfree==1?" ₹ 0":payone==1?"  ₹ 199":paytwo==1?" ₹ 699":paythree==1?" ₹ 1000":"Error",
                        style: TextStyle(
                            fontSize: 25.0, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
          //  ClipRRect(
          //           borderRadius: BorderRadius.circular(200.0),
          //           child:
          //           // _currentUser.photoUrl.toString()=="null"?
          //           // Text("No image")
          //           // Image.network("https://nofrdz.com/images/l.png")
          //           Icon(Icons.check_circle_outline,
          //           size:200
          //           )
          //           // :Image.network(_currentUser.photoUrl.toString())
          //           //  Image.asset("assets/images/userimg.png")
          //         ),
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
        ]
      )
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
      Navigator.pushNamed(context,"/paperback" );
      
      // Navigator.pop(context);
      // Navigator.of(context).pushNamedAndRemoveUntil('/paperback', (_) => false);
      
      // Navigator.popAndPushNamed(context,"/paperback");

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
    print("updated free "+ global.subPlan);
  } catch (e) {
    print(e.toString());
  }
  
  // print("account page");
}
