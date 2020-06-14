import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:nutshell/short.dart';
import 'package:pin_code_fields/pin_code_fields.dart';


class Otp extends StatefulWidget {
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> with TickerProviderStateMixin{
    var onTapRecognizer;

  TextEditingController textEditingController = TextEditingController();
                        //  ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  String currentText = "";

  
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
 
  void initState() {
    // TODO: implement initState
  
    onTapRecognizer = TapGestureRecognizer()
      ..onTap = () {
        Navigator.pop(context);
      };
    errorController = StreamController<ErrorAnimationType>();

    super.initState();
 
  }

  @override
  void dispose() {
       errorController.close();
    textEditingController.dispose();
    super.dispose();
  }

 Future<void> PhoneS(String smsCode) async {
    var firebaseAuth = await FirebaseAuth.instance;

    _authCredential = await PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);
    firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
      setState(() {
        status = 'Something has gone wrong, please try later';
      });
    }).then((user) async {
      if (user.additionalUserInfo.isNewUser) {
        print("firest uset");
        return Navigator.pushNamed(context, '/subs');
      }
      setState(() {
        status = 'Authentication successful';
      });
      final Firestore _firestore = Firestore.instance;

      try {
        FirebaseUser user = await FirebaseAuth.instance.currentUser();
        print(user.toString());

        if (user != null) {
          DocumentSnapshot _docSnap =
              await _firestore.collection("users").document(user.uid).get();

          await new Future.delayed(const Duration(milliseconds: 5000));
          if (_docSnap.data['subscription']) {
            Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
          } else {
            Navigator.pushNamed(context, "/subs");
          }
        } else {
          // Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
          // goToLoginPage();
          await new Future.delayed(const Duration(milliseconds: 5000));
          Navigator.pushNamedAndRemoveUntil(context, "/intro", (_) => false);
        }
      } catch (e) {
        print(e);
      }

      // Navigator.pushNamed(context, '/subs');
    });
  }

  Future<void> verifyPhone() async {
    var firebaseAuth = await FirebaseAuth.instance;

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.actualCode = verificationId;
      // smsCodeDialog(context).then((value) {
      //   print("signed in");
      // });

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
    final PhoneVerificationCompleted verificationCompleted =
        (AuthCredential auth) {
      setState(() {
        status = 'Auto retrieving verification code';
      });
       textEditingController.text=actualCode ;

      _authCredential = auth;
      print("auth");
              Navigator.pushNamed(context, "otp",arguments: phoneNo);

      firebaseAuth
          .signInWithCredential(_authCredential)
          .then((AuthResult value) async {
        if (value.additionalUserInfo.isNewUser) {
          print("firest uset");
          return Navigator.pushNamed(context, '/subs');
        }
        setState(() {
          status = 'Authentication successful';
        });
        final Firestore _firestore = Firestore.instance;

        try {
          FirebaseUser user = await FirebaseAuth.instance.currentUser();
          print(user.toString());

          if (user != null) {
            DocumentSnapshot _docSnap =
                await _firestore.collection("users").document(user.uid).get();

            await new Future.delayed(const Duration(milliseconds: 5000));
            if (_docSnap.data['subscription']) {
              Navigator.pushNamedAndRemoveUntil(context, "/home", (_) => false);
            } else {
              Navigator.pushNamed(context, "/subs");
            }
          } else {
            // Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
            // goToLoginPage();
            await new Future.delayed(const Duration(milliseconds: 5000));
            Navigator.pushNamedAndRemoveUntil(context, "/intro", (_) => false);
          }
        } catch (e) {
          print(e);
        }

        // Navigator.pushNamed(context, '/subs');
      });
    };
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: phoneNo,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
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
        Navigator.pushNamed(context, "otp",arguments: phoneNo);
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
          // Navigator.pushNamed(context, '/Login');
          PhoneS(value);
        }
      });
      // return null;
    }
  }

  @override
  Widget build(BuildContext context) {
   phoneNo=ModalRoute.of(context).settings.arguments;
    SizeConfig().init(context);
  //  String i=ModalRoute.of(context).settings.arguments;
    textEditingController.text="1526";//0 is for otp
    
    return
         Scaffold(      key: _scaffoldKey,

          body: 
          SingleChildScrollView(
            child:
        Container(
     
      width: SizeConfig.wt,

   
      child: Column(
        children: <Widget>[
          // Center(
          //   child: Padding(
          //     padding: const EdgeInsets.only(top:15.0),
          //     child: Text(
          //       "OTP Verification",
          //       style:
          //           TextStyle(color: Theme.of(context).primaryColor, fontSize: 33,fontWeight: FontWeight.w600),
          //     ),
          //   ),
          // ),
          // SizedBox(height:SizeConfig.ht*0.1),
           Padding(
             padding:  EdgeInsets.only(top:50.0),
             child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "One time password(OTP) has been ",
                    style: TextStyle(
                        color: Colors.grey, fontSize: 20),
                  ),
                   Text(
                    "sent to your mobile ",
                    style: TextStyle(
                        color: Colors.grey, fontSize: 20),
                  ),
                  ]),
           ),
          //  Padding(
          //    padding: const EdgeInsets.all(8.0),
          //    child: Center(
          //      child:Text(
          //                     "+91-${i}",//1 is for phone number
                              
          //                     style: TextStyle(
          //                         color: Theme.of(context).primaryColor,
          //                         fontSize: 25,
          //                         fontWeight: FontWeight.w400),
          //                   ), 
          //    ),
          //  ),
            Center(
              child: Text(
                      "Please enter the same here",
                      style: TextStyle(
                          color: Colors.grey, fontSize: 20),
                    ),
            ),

            GestureDetector(
                          child: Container(
                            width: SizeConfig.wt*0.5,
                            child: PinCodeTextField(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              length: 4,
                              obsecureText: false,
                              animationType: AnimationType.fade,
                              pinTheme: PinTheme(
                                shape: PinCodeFieldShape.underline,
                                // borderRadius: BorderRadius.circular(5),
                                fieldHeight: 50,
                                fieldWidth: 40,
                                activeFillColor: Colors.white,
                                inactiveFillColor: Colors.white,
                                selectedFillColor: Colors.white,
                                inactiveColor: Colors.grey
                              ),
                              animationDuration: Duration(milliseconds: 300),
                              // backgroundColor: Colors.blue.shade50,
                              enableActiveFill: true,
                              errorAnimationController: errorController,
                              controller: textEditingController,
                              onCompleted: (v) {
                                print("Completed");
                              },
                              onChanged: (value) {
                                print(value);
                                                  //frescd /var/www/html/apis/freshMeat-api

                                setState(() {
                                  currentText = value;
                                });
                              },
                              beforeTextPaste: (text) {
                                print("Allowing to paste $text");
                                //if you return true then it will show the paste confirmation dialog. Otherwise if false, then nothing will happen.
                                //but you can show anything you want here, like your pop up saying wrong paste format or etc
                                return true;
                              },
                            ),
                          ),
            ),
            Padding(
                          padding: EdgeInsets.only(top: SizeConfig.ht * 0.045),
                          child: RaisedButton(
                              padding: EdgeInsets.only(
                                  top: SizeConfig.ht * 0.01,
                                  bottom: SizeConfig.ht * 0.01,
                                  left: SizeConfig.wt * 0.2,
                                  right: SizeConfig.wt * 0.2),
                              color: Theme.of(context).primaryColor,
                              onPressed: () {
                               verifyPhone();
                              },
                              shape: RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(50.0),
                              ),
                              child: Text("VERIFY OTP",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 22))),
                        ),
                       
                        Center(
                            child: Padding(
                          padding: EdgeInsets.only(
                              top: SizeConfig.ht * 0.018, bottom: SizeConfig.ht * 0.018),
                          child: FlatButton(
                            onPressed: () {
                              print("Resend OTP");
                            },
                            child: Text(
                              "Resend OTP",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 22),
                            ),
                          ),
                        )),

         
 
         
        ],
      ),
    )
      ),
    );
  }
}