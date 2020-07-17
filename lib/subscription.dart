import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:nutshell/database.dart';
import 'package:nutshell/users.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'currentUser.dart';
import 'details.dart';
import 'account.dart';
import 'orderConfirmation.dart';
import 'global.dart' as global;

bool selection1 = false;

String sID;
Razorpay razorpay;
int payfree = 0;
int payone = 0;
int paytwo = 0;
int paythree = 0;
final CollectionReference users = Firestore.instance.collection('users');
Users _currentUser = Users();
Users get getCurrentUser => _currentUser;

class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

enum en { f, b, s, p }
Map pay = {0: payfree, 1: payone, 2: paytwo, 3: paythree};

class _SubscriptionState extends State<Subscription> {
  var oneval = false;
  var twoval = false;
  bool isVisible = false;
  int svgIndex;
  var threeval = false;

  static const List<String> svgNames = <String>[
    "assets/images/7Days.svg",
    "assets/images/2Months.svg",
    "assets/images/6Months.svg",
    "assets/images/1Year.svg",
  ];
  @override
  Widget build(BuildContext context) {
    callSet(String sv) {
      setState(() {
        isVisible == true && svgIndex != svgNames.indexOf(sv)
            ? isVisible = true
            : isVisible = !isVisible;
        svgIndex = svgNames.indexOf(sv);
      });
    }

    return Scaffold(
        backgroundColor: Colors.white,
        // appBar: AppBar(
        //   centerTitle: true,
        //   title: Text("Pick your subscription plan",
        //       style: Theme.of(context).textTheme.headline6),
        //   backgroundColor: Colors.white,
        //   elevation: 0.0,
        //   // iconTheme: IconThemeData(
        //   //   color: Colors.black,
        //   //   size: 80.0,
        //   // ),
        // ),
        body:
            // Container(
            // margin: EdgeInsets.only(top: 10, left: 7, right: 7),
            // child:
            ListView(
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              "Pick your subscription plan",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 45.0, fontWeight: FontWeight.bold),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.65,
              width: MediaQuery.of(context).size.width * 1.4,
              child: CarouselSlider(
                  options: CarouselOptions(
                    aspectRatio: 8 / 25,
                    autoPlay: false,
                    enableInfiniteScroll: false,

                    // height: 2000,
                    // width: MediaQuery.of(context).size.height * 0.90,
                  ),
                  items: svgNames.map((sv) {
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                            onTap: () {
                              callSet(sv);
                            },
                            child: Stack(
                              children: <Widget>[
                                Align(
                                  child: SvgPicture.asset(
                                    "$sv",
                                  ),
                                ),
                                Visibility(
                                    visible: isVisible
                                        ? svgNames.indexOf(sv) == svgIndex
                                            ? true
                                            : false
                                        : false,
                                    child: Positioned(
                                      left: MediaQuery.of(context).size.width *
                                          0.32,
                                      top: MediaQuery.of(context).size.height *
                                          0.05,
                                      child: Icon(
                                        Icons.check_circle,
                                        color: Color.fromRGBO(191, 30, 46, 1),
                                        size: 60,
                                      ),
                                    ))
                              ],
                            ));
                      },
                    );
                  }).toList()),
            ),
            Container(
              padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.width * 0.4,
                  right: 10.0,
                  bottom: 10),
              // child: Visibility(
              // visible: isVisible,
              child: RaisedButton(
                padding: EdgeInsets.only(
                    left: 22.0, right: 20.0, top: 10.0, bottom: 10.0),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0)),
                onPressed: isVisible == true
                    ? () {
                        setState(() {
                          global.subPlan = en.values[svgIndex].toString();
                          print("index of svg $svgIndex");
                          switch (svgIndex) {
                            case 0:
                              {
                                payfree = 1;
                                break;
                              }
                            case 1:
                              {
                                payone = 1;
                                break;
                              }

                            case 2:
                              {
                                paytwo = 1;
                                break;
                              }
                            case 3:
                              {
                                paythree = 1;
                                break;
                              }
                          }
                        });

                        print(pay.values.toList()[svgIndex].toString());
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Details()));
                      }
                    : null,
                disabledColor: Colors.grey,
                color: Colors.redAccent[700],
                child: Center(
                  child: Text(
                    'Continue',
                    style:
                        TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              // ),
            )
          ],
        )
        // )
        );
  }

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();
  }

  @override
  void dispose() {
    super.dispose();
    razorpay.clear();
    setState(() {
      selection1 = false;
      payone = 0;
      paythree = 0;
      paytwo = 0;
    });
  }
}

void openCheckout(BuildContext context) async {
  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // String selectedPlan=global.subPlan;
    Fluttertoast.showToast(
      msg: "SUCCESS: " + response.paymentId,
    );

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
    razorpay.clear();

    Navigator.pushReplacementNamed(context, '/bottombar');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
    );
  }

  print("Just came to opencheckout function");
  print(_currentUser.uid);

  var onemonth = {
    'key': 'rzp_live_A94dLEeQb2Cj5s',
    'currency': "INR",
    'amount': 110, //in the smallest currency sub-unit.
    'name': 'Nutshell',
    //'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'One month Nutshell Subscription',
    'prefill': {'contact': '+91' + global.phone, 'email': global.email}
  };

  try {
    print("Trying to go to razorpay");
    razorpay.open(onemonth);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  } catch (e) {
    print("catch block jp");
    debugPrint(e);
  }
}

void openCheckoutthree(BuildContext context) async {
  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // String selectedPlan=global.subPlan;
    Fluttertoast.showToast(
      msg: "SUCCESS: " + response.paymentId,
    );

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
    razorpay.clear();

    Navigator.pushReplacementNamed(context, '/bottombar');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
    );
  }

  print("Just came to checkout3 function");
  var threemonths = {
    'key': 'rzp_live_A94dLEeQb2Cj5s',
    'currency': "INR",
    'amount': 120, //in the smallest currency sub-unit.
    'name': 'Nutshell',
    //'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Nutshell Subscription',
    'prefill': {'contact': '+91' + global.phone, 'email': global.email}
  };
  try {
    print("Trying to go to razorpay");
    razorpay.open(threemonths);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  } catch (e) {
    print("catch block jp");
    debugPrint(e);
  }
}

void openCheckoutyear(BuildContext context) async {
  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // String selectedPlan=global.subPlan;
    Fluttertoast.showToast(
      msg: "SUCCESS: " + response.paymentId,
    );

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
    razorpay.clear();

    Navigator.pushReplacementNamed(context, '/bottombar');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
    );
  }

  print("Just came to checkoutyear function");
  var oneyear = {
    'key': 'rzp_live_A94dLEeQb2Cj5s',
    'currency': "INR",
    'amount': 130, //in the smallest currency sub-unit.
    'name': 'Nutshell',
    //'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Nutshell Subscription',
    'prefill': {'contact': '+91' + global.phone, 'email': global.email}
  };
  try {
    print("Trying to go to razorpay");
    razorpay.open(oneyear);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);

    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  } catch (e) {
    print("catch block jp");
    debugPrint(e);
  }
}

void openCheckoutweek(BuildContext context) async {
  _handlePaymentSuccess(PaymentSuccessResponse response) async {
    // String selectedPlan=global.subPlan;
    Fluttertoast.showToast(
      msg: "SUCCESS: " + response.paymentId,
    );

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
    razorpay.clear();

    Navigator.pushReplacementNamed(context, '/bottombar');
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
      msg: "ERROR: " + response.code.toString() + " - " + response.message,
    );
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
      msg: "EXTERNAL_WALLET: " + response.walletName,
    );
  }

  print("Just came to checkout functionfds");
  print(global.phone);
  var oneweek = {
    'key': 'rzp_live_A94dLEeQb2Cj5s',
    'currency': "INR",
    'amount': 00, //in the smallest currency sub-unit.
    'name': 'Nutshell',
    // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Nutshell Subscription',
    'prefill': {'contact': '+91' + global.phone, 'email': global.email}
  };
// print("Just before going to razorpay try");
  try {
    print("Trying to go to razorpay");
    // sendToServer();
    // razorpay.open(oneweek);
  } catch (e) {
    print("catch block jp");
    debugPrint(e);
  }
}

//  navigator(BuildContext context){
//     Navigator.pushNamedAndRemoveUntil(context, '/bottombarScreen', (route) => false);
//     }

void _handlePaymentError(PaymentFailureResponse response) {
  Fluttertoast.showToast(
    msg: "ERROR: " + response.code.toString() + " - " + response.message,
  );
}

void _handleExternalWallet(ExternalWalletResponse response) {
  Fluttertoast.showToast(
    msg: "EXTERNAL_WALLET: " + response.walletName,
  );
}

// class Details extends StatefulWidget {

//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   Users _currentUser = Users();

// _DetailsState({
//     Key key,
//   });

//   bool _validate = false;
//   @override
//   void initState() {
//     super.initState();
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final text = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         iconTheme: IconThemeData(
//           color: Colors.black,
//           size: 80.0,
//         ),
//       ),
//       body: Center(
//         child: new Form(
//           key: _formKey,
//           autovalidate: _validate,
//           child: FormUI(),
//         ),
//       ),
//     );
//   }

//   Widget FormUI() {
//     _currentUser.sID = sID;
//     return SingleChildScrollView(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: <Widget>[
//           SizedBox(
//             width: MediaQuery.of(context).size.width - 100,
//             child: Text(
//               "Enter your Details",
//               style: TextStyle(
//                 color: Colors.black,
//                 fontSize: 25,
//                 fontWeight: FontWeight.bold,
//               ),
//               textAlign: TextAlign.left,
//             ),
//           ),
//           Padding(padding: EdgeInsets.all(50)),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 width: 140,
//                 child: TextFormField(
//                   autovalidate: true,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(hintText: 'Enter First Name'),
//                     validator: validateName,
//                     onSaved: (String value) {
//                       _currentUser.fname = value;
//                     }),
//               ),
//               SizedBox(
//                 width: 140,
//                 child: TextFormField(
//                   autovalidate: true,
//                     keyboardType: TextInputType.text,
//                     decoration: InputDecoration(hintText: 'Enter Last Name'),
//                     validator: validateName,
//                     onSaved: (String value) {
//                       _currentUser.lname = value;
//                     }),
//               ),
//             ],
//           ),
//           Padding(padding: EdgeInsets.all(10)),
//           SizedBox(
//             width: 320,
//             child: TextFormField(
//               autovalidate: true,
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(hintText: 'Enter School Name'),
//                 validator: validateSchool,
//                 onSaved: (String value) {
//                   _currentUser.school = value;
//                 }),
//           ),
//           Padding(padding: EdgeInsets.all(10)),
//           SizedBox(
//             width: 320,
//             child: TextFormField(
//               autovalidate: true,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(hintText: 'Enter Class'),
//                 validator: validateClass,
//                 onSaved: (String value) {
//                   _currentUser.grade = value;
//                 }),
//           ),
//           Padding(padding: EdgeInsets.all(10)),
//           SizedBox(
//             width: 320,
//             child: TextFormField(
//               autovalidate: true,
//                 keyboardType: TextInputType.emailAddress,
//                 decoration: InputDecoration(hintText: 'Enter Email Address'),
//                 validator: validateEmail,
//                 onSaved: (String value) {
//                   _currentUser.email = value;
//                 }),
//           ),
//           Padding(padding: EdgeInsets.all(10)),
//           SizedBox(
//             width: 320,
//             child: TextFormField(
//               autovalidate: true,
//                 keyboardType: TextInputType.text,
//                 decoration: InputDecoration(hintText: 'Enter City'),
//                 validator: validateCity,
//                 onSaved: (String value) {
//                   _currentUser.city = value;
//                 }),
//           ),
//           Padding(padding: EdgeInsets.all(10)),
//           SizedBox(
//             width: 320,
//             child: TextFormField(
//               autovalidate: true,
//                 keyboardType: TextInputType.number,
//                 decoration: InputDecoration(hintText: 'Enter global.phone Number', prefix: Text("+91")),
//                 validator: validateglobal.phone,
//                 onSaved: (String value) {
//                   _currentUser.global.phone = value;
//                 }),
//           ),
//           SizedBox(
//             height: MediaQuery.of(context).size.height / 6,
//           ),
//           BottomAppBar(
//             child: GestureDetector(
//               onTap: () {

//                 if (payone==1) {
//                   openCheckout();
//                 } else if (paytwo== 1) {
//                   openCheckoutthree();
//                 } else if (paythree==1) {
//                   openCheckoutyear();
//                 }
//                 // print(_currentUser.fname);
//                 // Users users = Users();
//                 // OurDatabase().createUser(users);
//               },
//               child: Container(
//                 width: MediaQuery.of(context).size.width - 50,
//                 height: 62.5,
//                 child: Center(
//                   child: SizedBox(
//                     width: 100,
//                     child: Text(
//                       'Submit',
//                       style: TextStyle(
//                           fontSize: 20,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold),
//                       textAlign: TextAlign.center,
//                     ),
//                   ),
//                 ),
//                 color: Colors.deepOrange,
//               ),
//             ),
//           )
//         ],
//       ),
//     );
//   }

//   sendToServer() async {
//     // Users _user = Users();
//     if (_formKey.currentState.validate()) {
//       // No any error in validation
//       _formKey.currentState.save();
//       OurDatabase().createUser(_currentUser);
//       print(_currentUser.fname);
//       print( _currentUser.city);
//     } else {
//       // validation error
//       setState(() {
//         _validate = true;
//       });
//     }
//   }
// }

// String validateName(String value) {
//   String pattern = r'(^[a-zA-Z ]*$)';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length <= 2) {
//     return "Name is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Name must be a-z and A-Z";
//   }
//   return null;
// }

// String validateSchool(String value) {
//   String pattern = r'(^[a-zA-Z ]*$)';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length <= 2) {
//     return "School Name is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Special characters not allowed";
//   }
//   return null;
// }

// String validateClass(String value) {
//   String pattern = '([0-2]{2}|[123456789])';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length == 0) {
//     return "Class is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Class must be between 1-12";
//   }
//   return null;
// }

// String validateCity(String value) {
//   String pattern = r'(^[a-zA-Z ]*$)';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length == 0) {
//     return "City is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Please enter a valid City";
//   }
//   return null;
// }

// String validateEmail(String value) {
//   String pattern =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length == 0) {
//     return "Email is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Invalid Email";
//   } else {
//     return null;
//   }
// }
// String validateglobal.phone(String value) {
// // Indian Mobile number are of 10 digit only
//     if (value.length != 10)
//       return 'Mobile Number must be of 10 digit';
//     else
//       return null;
//   }
