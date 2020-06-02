
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutshell/database.dart';
import 'package:nutshell/users.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'currentUser.dart';
import 'details.dart';
import 'home.dart';
import 'account.dart';

bool selection1 = false;

String sID;
Razorpay razorpay;
int payfree = 0;
int payone =0;
int paytwo = 0;
int paythree = 0;
final CollectionReference users = Firestore.instance.collection('users');
Users _currentUser = Users();
Users get getCurrentUser => _currentUser;


class Subscription extends StatefulWidget {
  @override
  _SubscriptionState createState() => _SubscriptionState();
}

class _SubscriptionState extends State<Subscription> {


  var oneval = false;
  var twoval = false;
  var threeval = false;

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text("Pick your subscription plan",
            style: Theme.of(context).textTheme.headline6),
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 80.0,
        ),
      ),
      body: Container(
        

          child: ListView(
              children: ListTile.divideTiles(context: context, tiles: [
        ListTile(
          selected: true,
          trailing: Column(
            children: [
              Text("₹0/-",
                  style: TextStyle(fontSize: 30, color: Colors.black)),
              Text("Two issues",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange)),
            ],
          ),
          contentPadding: EdgeInsets.all(30),
          onTap: () {
            setState(() {
              selection1 = true;
              payfree=1;
            });
           Navigator.push(context, MaterialPageRoute(builder: (context) => Details()));
          },
          title: Text(
            "FREE",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            "7 Days \n2 Paperbacks",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
                
        ListTile(
          selected: true,
          trailing: Column(
            children: [
              Text("₹69/-",
                  style: TextStyle(fontSize: 30, color: Colors.black)),
              Text("One issue",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange)),
            ],
          ),
          contentPadding: EdgeInsets.all(30),
          onTap: () {
            setState(() {
              selection1 = true;
              payone=1;
            });
           Navigator.push(context, MaterialPageRoute(builder: (context) => Details()));
          },
          title: Text(
            "Basic",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            "2 months \n1 Paperbacks",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
        ListTile(
          trailing: Column(
            children: [
              Text("₹56/-",
                  style: TextStyle(fontSize: 30, color: Colors.black)),
              Text("per issue",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange)),
            ],
          ),
          contentPadding: EdgeInsets.all(30),
          onTap: () {
            setState(() {
              selection1 = true;
              paytwo=1;
            });
           Navigator.push(context, MaterialPageRoute(builder: (context) => Details()));
          },
          title: Text(
            "Standard",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            "6 months \n3 Paperbacks",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          selected: true,
        ),
        ListTile(
          trailing: Column(
            children: [
              Text("₹50/-",
                  style: TextStyle(fontSize: 30, color: Colors.black)),
              Text("per issue",
                  style: TextStyle(fontSize: 20, color: Colors.deepOrange)),
            ],
          ),
          contentPadding: EdgeInsets.all(30),
          onTap: () {
            setState(() {
              selection1 = true;
            paythree=1;
            });
            
            Navigator.push(context, MaterialPageRoute(builder: (context) => Details()));
          },
          title: Text(
            "Premium",
            style: TextStyle(
              fontSize: 30,
              color: Colors.black,
            ),
          ),
          subtitle: Text(
            "12 months \n6 Paperbacks",
            style: TextStyle(
              fontSize: 20,
            ),
          ),
          selected: true,
        ),
      ]).toList())),
    );
  }

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();

    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
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

void openCheckout() async {
  
  print("Just came to opencheckout function");
    print(_currentUser.uid);

  var onemonth = {
    'key': 'rzp_test_b3k6BBYp7rce8M',
    'currency': "INR",
    'amount': 6900, //in the smallest currency sub-unit.
    'name': 'Nutshell',
    //'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'One month Nutshell Subscription',
     'prefill': {'contact': '+91'+ phone, 'email': email}
  };

  try {
    
    print("Trying to go to razorpay");
    razorpay.open(onemonth);
  } catch (e) {
    print("catch block jp");
    debugPrint(e);
  }
}

void openCheckoutthree() async {
  
  print("Just came to checkout3 function");
  var threemonths = {
    'key': 'rzp_test_b3k6BBYp7rce8M',
    'currency': "INR",
    'amount': 16800, //in the smallest currency sub-unit.
    'name': 'Nutshell',
    //'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Nutshell Subscription',
    'prefill': {'contact': '+91'+phone, 'email': email}
  };
  try {
    
    print("Trying to go to razorpay");
    razorpay.open(threemonths);
  } catch (e) {
    
    print("catch block jp");
    debugPrint(e);
  }
}

void openCheckoutyear() async {
  
  print("Just came to checkoutyear function");
  var oneyear = {
    'key': 'rzp_test_b3k6BBYp7rce8M',
    'currency': "INR",
    'amount': 29900, //in the smallest currency sub-unit.
    'name': 'Nutshell',
    //'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Nutshell Subscription',
    'prefill': {'contact':'+91'+ phone, 'email': email}
  };
  try {
    
    print("Trying to go to razorpay");
    razorpay.open(oneyear);
  } catch (e) {
    
    print("catch block jp");
    debugPrint(e);
  }
}

void openCheckoutweek() async {
  print("Just came to checkout functionfds");
  print(phone);
  var oneweek = {
    'key': 'rzp_test_b3k6BBYp7rce8M',
    'currency': "INR",
    'amount': 00, //in the smallest currency sub-unit.
    'name': 'Nutshell',
    // 'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
    'description': 'Nutshell Subscription',
    'prefill': {'contact':'+91'+ phone, 'email': email}
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


void _handlePaymentSuccess(PaymentSuccessResponse response) async {
  Fluttertoast.showToast(
    msg: "SUCCESS: " + response.paymentId,
  );

  try{
FirebaseUser user = await FirebaseAuth.instance.currentUser();
  print("current user id");
  print(user.uid);
   final Firestore fireStore =  Firestore.instance;
  await fireStore.collection("users").document(user.uid).updateData({
    "subscription": true
});
    print("updated");

}
catch(e){
  print(e.toString());
}

print("account page");
  HomeScreen();
  }
  
//  navigator(BuildContext context){
//     Navigator.pushNamedAndRemoveUntil(context, '/HomeScreen', (route) => false);
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
//                 decoration: InputDecoration(hintText: 'Enter Phone Number', prefix: Text("+91")),
//                 validator: validatePhone,
//                 onSaved: (String value) {
//                   _currentUser.phone = value;
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
// String validatePhone(String value) {
// // Indian Mobile number are of 10 digit only
//     if (value.length != 10)
//       return 'Mobile Number must be of 10 digit';
//     else
//       return null;
//   }
 



