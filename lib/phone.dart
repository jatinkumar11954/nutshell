// import 'package:flutter/material.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/services.dart';
// import 'package:nutshell/home.dart';

// class Phone extends StatefulWidget {
//   Phone({Key key, this.title}) : super(key: key);
//   final String title;

//   @override
//   _PhoneState createState() => _PhoneState();
// }

// class _PhoneState extends State<Phone> {
//   String phoneNo;
//   String smsOTP;
//   String verificationId;
//   String errorMessage = '';
//   FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<void> verifyPhone() async {
//     final PhoneCodeSent smsOTPSent = (String verId, [int forceCodeResend]) {
//       this.verificationId = verId;
//       smsOTPDialog(context).then((value) {
//         print('sign in');
//         // Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new HomeScreen()),(_)=> false);
//       });
//     };
//     try {
//       await _auth.verifyPhoneNumber(
//           phoneNumber: this.phoneNo, // PHONE NUMBER TO SEND OTP
//           codeAutoRetrievalTimeout: (String verId) {
//             //Starts the phone number verification process for the given phone number.
//             //Either sends an SMS with a 6 digit code to the phone number specified, or sign's the user in and [verificationCompleted] is called.
//             this.verificationId = verId;
//           },
//           codeSent:
//               smsOTPSent, // WHEN CODE SENT THEN WE OPEN DIALOG TO ENTER OTP.
//           timeout: const Duration(seconds: 20),
//           verificationCompleted: (AuthCredential phoneAuthCredential) {
//             print(phoneAuthCredential);
//           },
//           verificationFailed: (AuthException exceptio) {
//             print('${exceptio.message}');
//           });
//     } catch (e) {
//       handleError(e);
//     }
//   }

//   Future<bool> smsOTPDialog(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: false,
//         builder: (BuildContext context) {
//           return new AlertDialog(
//             title: Text('Enter SMS Code'),
//             content: Container(
//               height: 85,
//               child: Column(children: [
//                 TextField(
//                   keyboardType: TextInputType.number,
//                   onChanged: (value) {
//                     this.smsOTP = value;
//                   },
//                 ),
//                 (errorMessage != ''
//                     ? Text(
//                         errorMessage,
//                         style: TextStyle(color: Colors.red),
//                       )
//                     : Container())
//               ]),
//             ),
//             contentPadding: EdgeInsets.all(10),
//             actions: <Widget>[
//               Center(
//                 child: FlatButton(
//                   child: Text('Done'),
//                   onPressed: () {
//                     _auth.currentUser().then((user) {
//                       if (user != null) {
//                         Navigator.of(context).pop();
//                         Navigator.of(context).pushNamed('/subs');
//                       } else {
//                         signIn();
//                       }
//                     });
//                   },
//                 ),
//               )
//             ],
//           );
//         });
//   }

//   signIn() async {
//     try {
//       final AuthCredential credential = PhoneAuthProvider.getCredential(
//         verificationId: verificationId,
//         smsCode: smsOTP,
//       );
//       final FirebaseUser user =
//           (await _auth.signInWithCredential(credential)) as FirebaseUser;
//       final FirebaseUser currentUser = await _auth.currentUser();
//       assert(user.uid == currentUser.uid);
//       Navigator.of(context).pop();
//       Navigator.of(context).pushNamed('/subs');
//     } catch (e) {
//       handleError(e);
//     }
//   }

//   handleError(PlatformException error) {
//     print(error);
//     switch (error.code) {
//       case 'ERROR_INVALID_VERIFICATION_CODE':
//         FocusScope.of(context).requestFocus(new FocusNode());
//         setState(() {
//           errorMessage = 'Invalid Code';
//         });
//         Navigator.of(context).pop();
//         smsOTPDialog(context).then((value) {
//           print('sign in');
//         });
//         break;
//       default:
//         setState(() {
//           errorMessage = error.message;
//         });

//         break;
//     }
//   }

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
//         child: SingleChildScrollView(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: <Widget>[
//               SizedBox(
//                 width: MediaQuery.of(context).size.width - 100,
//                 child: Text(
//                   "Enter your Phone Number for verification",
//                   style: TextStyle(
//                     color: Colors.black,
//                     fontSize: 25,
//                     fontWeight: FontWeight.bold,
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               SizedBox(
//                 height: 50,
//                 width: MediaQuery.of(context).size.width - 100,
//                 child: Text(
//                   "Your phone number will be used to login into Nutshell",
//                   style: TextStyle(
//                     fontSize: 15,
//                     color: Colors.grey,
//                   ),
//                   textAlign: TextAlign.left,
//                 ),
//               ),
//               SizedBox(
//                 width: 300,
//                 child: TextField(
//                   keyboardType: TextInputType.number,
//                   decoration: InputDecoration(hintText: 'Enter Phone Number'),
//                   onChanged: (value) {
//                     this.phoneNo = "+91" + value;
//                   },
//                 ),
//               ),
//               (errorMessage != ''
//                   ? Text(
//                       errorMessage,
//                       style: TextStyle(color: Colors.red),
//                     )
//                   : Container()),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height / 2 - 90,
//               ),
//               BottomAppBar(
//                 child: GestureDetector(
//                   onTap: () {
//                     verifyPhone();
//                   },
//                   child: Container(
//                     width: MediaQuery.of(context).size.width - 50,
//                     height: 62.5,
//                     child: Center(
//                       child: SizedBox(
//                         width: 100,
//                         child: Text(
//                           'Submit',
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//                       ),
//                     ),
//                     color: Colors.deepOrange,
//                   ),
//                 ),
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'short.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // bool _isLoading = false;

  void callSnackBar(String msg, [int er]) {
    // msg="There is no record with this user, please register first by clicking Register or check the user mail id or Password";
    final SnackBar = new prefix0.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 1),
      // action: new SnackBarAction(label: "Register",
      // onPressed: (){
      //   Navigator.pushNamed(context, "Register");
      // },),
    );
    _scaffoldKey.currentState.showSnackBar(SnackBar);
  }

  String errorMessage = '';
  String status, actualCode;
  String phoneNo;
  String smsCode;
  String verificationId;
  var _authCredential;

  Future<void> PhoneS(String smsCode) async {
    var firebaseAuth = await FirebaseAuth.instance;

    _authCredential = await PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);
    firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
      setState(() {
        status = 'Something has gone wrong, please try later';
      });
    }).then((user) {
      if (user.additionalUserInfo.isNewUser) {
        print("firest uset");
        return Navigator.pushNamed(context, '/subs');
      }
      setState(() {
        status = 'Authentication successful';
      });
      Navigator.pushNamed(context, '/subs');
    });
  }

  Future<void> verifyPhone() async {
    var firebaseAuth = await FirebaseAuth.instance;

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.actualCode = verificationId;
      smsCodeDialog(context).then((value) {
        print("signed in");
      });

      setState(() {
        print('Code sent to $phoneNo');
        status = "\nEnter the code sent to " + phoneNo;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.actualCode = verificationId;
      setState(() {
        status = "\nAuto retrieval time out";
      });
    };
    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        status = '${authException.message}';

        print("Error message: " + status);
        if (authException.message.contains('not authorized'))
          status = 'Something has gone wrong, please try later';
        else if (authException.message.contains('Network'))
          status = 'Please check your internet connection and try again';
        else
          status = 'Something has gone wrong, please try later';
      });
    };
//     final PhoneCodeSent smsCodeSent =(String verId,[int forceCodeResend]){
//       this.verificationId=verId;
//       smsCodeDialog(context).then((value){
//         print("signed in");
//       });
//     };

    // final PhoneVerificationCompleted verificationCompleted =
    //     (AuthCredential auth) {
    //   setState(() {
    //     status = 'Auto retrieving verification code';
    //   });

    //   // _authCredential = auth;
    //   // print("auth");
    //   // firebaseAuth
    //   //     .signInWithCredential(_authCredential)
    //   //     .then((AuthResult value) {
    //   //   // if (value.user != null) {
    //   //   //   if (value.additionalUserInfo.isNewUser) {
    //   //   //     print("firest uset");
    //   //   //     return Navigator.pushNamed(context, "/subs", arguments: "otp");
    //   //   //  // return Navigator.pushNamedAndRemoveUntil(context, '/details', (route) => false, arguments: "otp");
    //   //   //   }
    //   //   //   setState(() {
    //   //   //     status = 'Authentication successful';
    //   //   //   });
    //   //   //    return Navigator.pushNamed(context, "/home", arguments: "otp");
    //   //   //   //return Navigator.pushNamedAndRemoveUntil(context, '/home', (route) => false);
    //   //   // } else {
    //   //   //   setState(() {
    //   //   //     status = 'Invalid code/invalid authentication';
    //   //   //   });
    //   //   //   return null;
    //   //   // }
    //   // }).catchError((error) {
    //   //   setState(() {
    //   //     status = 'Something has gone wrong, please try later';
    //   //   });
    //   // });
    // };
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 60),
        // verificationCompleted: verificationCompleted,
        verificationCompleted: (AuthCredential phoneAuthCredential) {
          print(phoneAuthCredential);
        },
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);

    // final PhoneVerificationCompleted verifiedSuccess = (FirebaseUser user){
    //   print("verified succcess");
    // };

    // final PhoneVerificationFailed veriFailed=(AuthException exception){
    //   print('${exception.message}');
    // };

    // await FirebaseAuth.instance.verifyPhoneNumber(
    //   phoneNumber: this.phoneNo,
    //   codeAutoRetrievalTimeout: autoRetrieve,
    //   codeSent:  smsCodeSent,
    //   timeout: const Duration(seconds: 3),
    //   verificationCompleted: verifiedSuccess,
    //   verificationFailed:  veriFailed,
    // );
  }

  Future<bool> smsCodeDialog(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0))),
            // elevation: 200.0,
            // backgroundColor: Colors.white60,
            title: Text("Please Enter SMS Code"),
            titlePadding: EdgeInsets.all(20.0),
            content: TextFormField(
              // maxLength: 6,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
              
                  //  labelStyle:textStyle,
                  labelText: "SMS Code",
                  hintText: "Enter your 6 digits SMS Code",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                          SizeConfig.blockSizeVertical * 1.5))),
              onChanged: (value) {
                this.smsCode = value;
              },
            ),
            contentPadding: EdgeInsets.all(10.0),
            actions: <Widget>[
              new FlatButton(
                child: Text("Done"),
                onPressed: () {
                  SmsValidator(smsCode);
                },
              )
            ],
          );
        });
  }

  // signIn(){
  //   FirebaseAuth.instance.signInWithPhoneNumber(
  //     verificationId: verificationId,
  //     smsCode: smsCode,

  //   ).then((user){
  //     Navigator.pushReplacementNamed(context, "HomeScreen");
  //   });

  // }

  String phoneValidator(String value) {
    if (value.length != 13 || value.length == null) {
      print("validation failed");
      // return 'Phone Number must be of 10 digits';
      callSnackBar("Phone Number must be of 10 digits");
      //return null;
    } else {
      callSnackBar("Sending Otp to mobile Number");
      verifyPhone();
      //return null;
    }
  }

  String SmsValidator(String value) {
    if (value.length != 6 || value.length == null) {
      print("validation failed");
      // return 'Phone Number must be of 10 digits';
      callSnackBar(
          "Please Enter Proper 6 digit SMS code sent to your Mobile Number");
    } else {
      callSnackBar("You are signing in please wait !!");
      FirebaseAuth.instance.currentUser().then((user) {
        if (user != null) {
          Navigator.of(context).pop();
          // Navigator.pushReplacementNamed(context, 'Main');
          Navigator.pushNamedAndRemoveUntil(context, '/subs', (route) => false);
        } else {
          // Navigator.of(context).pop();
          Navigator.pushNamed(context, '/Login');
          PhoneS(value);
        }
      });
     // return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    // TODOd: implement build
    // return Scaffold(
    //   key: _scaffoldKey,
    //   appBar: AppBar(
    //     backgroundColor: Colors.orange,
    //     title: Text("Login with Phone Number"),
    //   ),
    //   body: WillPopScope(
    //     onWillPop: () {
    //       Navigator.pushReplacementNamed(context, "Login");
    //     },
    //     child: new Column(
    //       children: <Widget>[
    //         Padding(
    //             padding: EdgeInsets.only(
    //                 top: SizeConfig.blockSizeVertical * 5.5,
    //                 bottom: SizeConfig.blockSizeVertical * 1.5,
    //                 right: SizeConfig.blockSizeVertical * 2.5),
    //             child: Text("Please Enter Your Mobile Number")),
    //         Padding(
    //           padding: EdgeInsets.only(
    //               top: SizeConfig.blockSizeVertical * 0.5,
    //               bottom: SizeConfig.blockSizeVertical * 1.5,
    //               left: SizeConfig.blockSizeVertical * 2.5,
    //               right: SizeConfig.blockSizeVertical * 2.5),
    //           child: TextFormField(
    //             // controller: phoneInput,
    //             onChanged: (value) {
    //               this.phone = "+91" + value;
    //             },
    //             maxLength: 10,
    //             validator: phoneValidator,
    //             keyboardType: TextInputType.number,
    //             // style:textStyle,
    //             // keyboardType: Text(),
    //             decoration: InputDecoration(
    //               // labelStyle:textStyle,

    //               labelText: "Mobile",
    //               hintText: "Enter your Mobile Number ",
    //               border: OutlineInputBorder(
    //                   borderRadius: BorderRadius.circular(
    //                       SizeConfig.blockSizeVertical * 2.5)),
    //             ),
    //           ),
    //         ),
    //         _isLoading
    //             ? CircularProgressIndicator()
    //             : SizedBox(
    //                 child: RaisedButton(
    //                 child: Text("Verify"),
    //                 color: Colors.green,
    //                 onPressed: () {
    //                   print("clicked verify button");
    //                   phoneValidator(phone);
    //                   setState(() {
    //                     print(" in first set");
    //                     _isLoading = true;
    //                   });
    //                   // callSnackBar("Sending Otp to mobile Number");
    //                   //  verifyPhone();
    //                   setState(() {
    //                     print("in 2 nd");
    //                     _isLoading = false;
    //                   });
    //                 },
    //               )),
    //       ],
    //     ),
    //   ),
    // );
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 80.0,
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  "Enter your Phone Number for verification",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width - 100,
                child: Text(
                  "Your phone number will be used to login into Nutshell",
                  style: TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(
                width: 300,
                child: TextField(
                  maxLength: 10,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(hintText: 'Enter Phone Number'),
                  onChanged: (value) {
                    this.phoneNo = "+91" + value;
                  },
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 2 - 90,
              ),
              BottomAppBar(
                child: GestureDetector(
                  onTap: () {

                    verifyPhone();
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width - 50,
                    height: 62.5,
                    child: Center(
                      child: SizedBox(
                        width: 100,
                        child: Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    color: Colors.deepOrange,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
