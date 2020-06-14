import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:nutshell/editprofilescreen.dart';
import 'short.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  bool isLoading=false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // bool _isLoading = false;

  void callSnackBar(String msg, [int er]) {
    // msg="There is no record with this user, please register first by clicking Register or check the user mail id or Password";
    final SnackBar = new prefix0.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 1),
  
    );
    _scaffoldKey.currentState.showSnackBar(SnackBar);
  }

  String errorMessage = '';
  String status, actualCode;
  String phoneNo;
  String smsCode;
  String verificationId;
  var _authCredential;

  


  String phoneValidator(String value) {
    if (value.length < 13 || value.length == null) {
      print("validation failed");
      // return 'Phone Number must be of 10 digits';
      callSnackBar("Phone Number must be of 10 digits");
      //return null;
    } else {
      verifyPhone();
        Navigator.pushNamed(context, "otp",arguments: phoneNo);
      //return null;
    }
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

                   Navigator.pushNamed(context, "otp",arguments: phoneNo);


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

 

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
                    setState(() {
                      isLoading=true;
                    });

                   phoneValidator(phoneNo);

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
