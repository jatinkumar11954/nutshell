import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';

import 'global.dart' as g;
import 'package:flutter/gestures.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:nutshell/phone.dart';
import 'package:nutshell/short.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class Otp extends StatefulWidget {
  String PhoneNo;
  Otp({this.PhoneNo});
  @override
  _OtpState createState() => _OtpState();
}

class _OtpState extends State<Otp> with TickerProviderStateMixin {
  bool _resendEnble = false;
  bool _continueEnble = false;

  var onTapRecognizer;
  bool _isLoading = false;
  TextEditingController textEditingController;
  //  ..text = "123456";

  StreamController<ErrorAnimationType> errorController;

  bool hasError = false;
  bool _pinEnable = false;

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
  AuthCredential _authCredential;
  bool btn_enable = false;
  Future<void> verifyPhone() async {
    setState(() {
      _pinEnable = false;
      _continueEnble = false;
      _resendEnble = false;
    });
    var firebaseAuth = await FirebaseAuth.instance;

    final PhoneCodeSent codeSent =
        (String verificationId, [int forceResendingToken]) async {
      this.actualCode = verificationId;
      // smsCodeDialog(context).then((value) {
      //   print("signed in");
      // });

      setState(() {
        print('Code sent to ${widget.PhoneNo}');
        callSnackBar("Code sent to ${widget.PhoneNo}");
        // status = "\nEnter the code sent to " + {widget.PhoneNo};
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.actualCode = verificationId;
      print("timeout");
      callSnackBar("Auto retrieval failed");
      // phn.clear();
      setState(() {
        _isLoading = false;
        _pinEnable = true;

        textEditingController = TextEditingController();
      });
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //         builder: (context) => Otp({widget.PhoneNo}: {widget.PhoneNo}),
      //         settings: RouteSettings(arguments: actualCode)));

      setState(() {
        status = "\nAuto retrieval time out";
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        _isLoading = false;
      });
      setState(() {
        status = '${authException.message}';
        callSnackBar("Please enter a valid phone number");
          Fluttertoast.showToast(
            timeInSecForIosWeb: 3,
      msg: "Please enter a valid phone number",
    );
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Phone()));


        print("Error message: " + status);
        setState(() {
          _isLoading = false;
        });
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
      callSnackBar("Auto retrieving verification code");

      _authCredential = auth;
      print("auth");

      firebaseAuth
          .signInWithCredential(_authCredential)
          .then((AuthResult value) async {
        if (value.additionalUserInfo.isNewUser) {
          print(value.user.uid);
          print("firest uset");
          setState(() {
            _isLoading = false;
          });
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
              setState(() {
                _isLoading = false;
              });

              Navigator.pushNamedAndRemoveUntil(
                  context, "/paperback", (_) => false);
            } else {
              setState(() {
                _isLoading = false;
              });
              g.isGLogin = false;
              Navigator.pushNamed(context, "/subs");
            }
          } else {
            // Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
            // goToLoginPage();
            await new Future.delayed(const Duration(milliseconds: 5000));
            setState(() {
              _isLoading = false;
            });
            Navigator.pushNamedAndRemoveUntil(context, "/intro", (_) => false);
          }
        } catch (e) {
          print(e);
          setState(() {
            _isLoading = false;
          });
        }

        // Navigator.pushNamed(context, '/subs');
      });
    };
    firebaseAuth.verifyPhoneNumber(
        phoneNumber: widget.PhoneNo,
        timeout: Duration(seconds: 60),
        verificationCompleted: verificationCompleted,
        verificationFailed: verificationFailed,
        codeSent: codeSent,
        codeAutoRetrievalTimeout: codeAutoRetrievalTimeout);
  }

  void initState() {
    // TODO: implement initState
    verifyPhone();

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
    setState(() {
      _isLoading = true;
    });
    callSnackBar("Validating otp");

    FirebaseAuth firebaseAuth = await FirebaseAuth.instance;
    print("smscode $smsCode");
    print("actual code $actualCode");

    _authCredential = await PhoneAuthProvider.getCredential(
        verificationId: actualCode, smsCode: smsCode);
    firebaseAuth.signInWithCredential(_authCredential).catchError((error) {
      setState(() {
        _resendEnble = true;

        status = 'Something has gone wrong, please try later';
      });
      setState(() {
        _isLoading = false;
      });
      callSnackBar("Otp timeout or invalid Otp");
    }).then((user) async {
      if (user.additionalUserInfo.isNewUser) {
        print(user.user.uid);
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
            setState(() {
              _isLoading = false;
            });
            Navigator.pushNamedAndRemoveUntil(
                context, "/paperback", (_) => false);
          } else {
            setState(() {
              _isLoading = false;
            });
            Navigator.pushNamed(context, "/subs");
          }
        } else {
          // Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
          // goToLoginPage();
          await new Future.delayed(const Duration(milliseconds: 5000));
          setState(() {
            _isLoading = false;
          });
          Navigator.pushNamedAndRemoveUntil(context, "/intro", (_) => false);
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        print(e);
      }

      // Navigator.pushNamed(context, '/subs');
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

  String SmsValidator(String value) {
    if (value.length != 6 || value.length == null) {
      print("validation failed");

      // return 'Phone Number must be of 10 digits';
      callSnackBar(
          "Please Enter Proper 6 digit SMS code sent to your Mobile Number");
    } else {
      callSnackBar("You are signing in please wait !!");

      // Navigator.of(context).pop();
      // Navigator.pushNamed(context, '/Login');
      PhoneS(value);
    }
    // return null;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    //  String i=ModalRoute.of(context).settings.arguments;
    //0 is for otp

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0.0,
          leading: new IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: Colors.black,
            ),
            tooltip: 'back',
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => Phone()));
            },
          ),
        ),
        key: _scaffoldKey,
        body: WillPopScope(
          onWillPop: () {
            textEditingController.clear();
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Phone()));
          },
          child: Container(
            padding: EdgeInsets.only(
                left: 20.0, top: 20.0, right: 10.0, bottom: 15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                Text(
                  'Please wait while we \nauto verify the otp.',
                  style: TextStyle(
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent[700]),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.03,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        '0:30',
                        style: TextStyle(
                            fontSize: 23,
                            color: _resendEnble ? Colors.black : Colors.grey),
                      ),
                      FlatButton(
                        onPressed: () => _resendEnble ? verifyPhone() : null,
                        child: Text(
                          'Resend otp',
                          style: TextStyle(
                              fontSize: 23,
                              color: _resendEnble ? Colors.black : Colors.grey),
                        ),
                      )
                    ],
                  ),
                ),
                PinCodeTextField(
                  enabled: _pinEnable,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,

                  length: 6, autoValidate: true,
                  obsecureText: false, enableActiveFill: true,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                      shape: PinCodeFieldShape.box,
                      borderRadius: BorderRadius.circular(10),
                      fieldHeight: 60,
                      fieldWidth: 45,
                      activeFillColor: Colors.grey[300],
                      inactiveFillColor: Colors.grey[300],
                      selectedFillColor: Colors.white,
                      inactiveColor: Colors.grey),
                  animationDuration: Duration(milliseconds: 300),
                  // backgroundColor: Colors.blue.shade50,
                  errorAnimationController: errorController,
                  controller: textEditingController,
                  onCompleted: (v) {
                    print("Completed");
                  },
                  validator: (v) {
                    if (v.length == 6) {
                      _continueEnble = true;
                    } else {
                      _continueEnble = false;
                    }
                  },
                  onChanged: (value) {
                    print(value);

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
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.05,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.1,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.07,
                  width: MediaQuery.of(context).size.width * 0.95,
                  child: RaisedButton(
                    color: _continueEnble ? Colors.redAccent[700] : Colors.grey,
                    onPressed: () =>
                        _continueEnble ? SmsValidator(currentText) : null,
                    child: Text(
                      'Continue',
                      style: TextStyle(
                          fontSize: 30.0,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0)),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
