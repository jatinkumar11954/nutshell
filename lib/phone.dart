import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'global.dart' as g;
import 'Otp.dart';
import 'package:nutshell/editprofilescreen.dart';
import 'short.dart';

class Phone extends StatefulWidget {
  @override
  _PhoneState createState() => _PhoneState();
}

class _PhoneState extends State<Phone> {
  bool isLoading = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  // bool _isLoading = false;
  TextEditingController phn = TextEditingController();
  void callSnackBar(String msg, [int er]) {
    // msg="There is no record with this user, please register first by clicking Register or check the user mail id or Password";
    final SnackBar = new prefix0.SnackBar(
      content: new Text(msg),
      duration: new Duration(seconds: 4),
    );
    _scaffoldKey.currentState.showSnackBar(SnackBar);
  }

  String errorMessage = '';
  String status, actualCode;
  String phoneNo;
  String smsCode;
  String verificationId;
  var _authCredential;
  bool btn_enable = false;

  String phoneValidator(String value) {
    if (value.length < 13 || value.length == null) {
      print("validation failed");
      // return 'Phone Number must be of 10 digits';
      callSnackBar("Phone Number must be of 10 digits");
      //return null;
    } else {
      setState(() {
        isLoading = true;
      });
      Navigator.push(context, MaterialPageRoute(builder: (context)=>Otp(PhoneNo: value,)));
      // verifyPhone();
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
        callSnackBar("Code sent to $phoneNo");
        status = "\nEnter the code sent to " + phoneNo;
      });
    };
    final PhoneCodeAutoRetrievalTimeout codeAutoRetrievalTimeout =
        (String verificationId) {
      this.actualCode = verificationId;
      print("timeout");
      callSnackBar("Auto retrieval failed");
      phn.clear();
      setState(() {
        isLoading = false;
      });
      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => Otp(PhoneNo: phoneNo),
              settings: RouteSettings(arguments: actualCode)));

      setState(() {
        status = "\nAuto retrieval time out";
      });
    };

    final PhoneVerificationFailed verificationFailed =
        (AuthException authException) {
      setState(() {
        isLoading = false;
      });
      setState(() {
        status = '${authException.message}';
        callSnackBar("Please enter a valid phone number");
        print("Error message: " + status);
        setState(() {
          isLoading = false;
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
            isLoading = false;
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
                isLoading = false;
              });

              Navigator.pushNamedAndRemoveUntil(
                  context, "/paperback", (_) => false);
            } else {
              setState(() {
                isLoading = false;
              });
              g.isGLogin = false;
              Navigator.pushNamed(context, "/subs");
            }
          } else {
            // Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
            // goToLoginPage();
            await new Future.delayed(const Duration(milliseconds: 5000));
            setState(() {
              isLoading = false;
            });
            Navigator.pushNamedAndRemoveUntil(context, "/intro", (_) => false);
          }
        } catch (e) {
          print(e);
          setState(() {
            isLoading = false;
          });
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

  @override
  void dispose() {
    phn.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      resizeToAvoidBottomPadding: false,
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
      body: Container(
        padding: EdgeInsets.only(left: 25.0, top: 10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Please enter \nyour number',
              style: TextStyle(
                  fontSize: 55.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent[700]),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.03,
            ),
            Text(
              'This number will be used to login to your \naccount via otp.',
              style: TextStyle(
                  fontSize: 25.0,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.15,
            ),
            TextFormField(
              autovalidate: true,
              validator: (String txt) {
                this.phoneNo = "+91" + txt;
                if (txt.length >= 1) {
                  Future.delayed(Duration.zero).then((_) {
                    setState(() {
                      btn_enable = true;
                    });
                  });
                } else {
                  Future.delayed(Duration.zero).then((_) {
                    setState(() {
                      btn_enable = false;
                    });
                  });
                }
              },
              style: TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
              cursorWidth: 2.0,
              cursorRadius: Radius.circular(10),
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                  prefix: Text(
                '+91\t',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              )),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.1,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.07,
              width: MediaQuery.of(context).size.width * 0.95,
              child: RaisedButton(
                color: Colors.redAccent[700],
                disabledColor: Colors.grey,
                onPressed: btn_enable == true
                    ? () {
                        phoneValidator(phoneNo);
                      }
                    : null,
                child: Text(
                  'Login with Phone',
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

      // Center(
      //   child: SingleChildScrollView(
      //     child: Column(
      //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //       crossAxisAlignment: CrossAxisAlignment.center,
      //       children: <Widget>[
      //         SizedBox(
      //           width: MediaQuery.of(context).size.width - 100,
      //           child: Text(
      //             "Enter your Phone Number for verification",
      //             style: TextStyle(
      //               color: Colors.black,
      //               fontSize: 25,
      //               fontWeight: FontWeight.bold,
      //             ),
      //             textAlign: TextAlign.left,
      //           ),
      //         ),
      //         SizedBox(
      //           height: 50,
      //           width: MediaQuery.of(context).size.width - 100,
      //           child: Text(
      //             "Your phone number will be used to login into Nutshell",
      //             style: TextStyle(
      //               fontSize: 15,
      //               color: Colors.grey,
      //             ),
      //             textAlign: TextAlign.left,
      //           ),
      //         ),
      //         SizedBox(
      //           width: 300,
      //           child: TextField(
      //             maxLength: 10,
      //             controller: phn,
      //             keyboardType: TextInputType.number,
      //             decoration: InputDecoration(hintText: 'Enter Phone Number'),
      //             onChanged: (value) {
      //               this.phoneNo = "+91" + value;
      //               g.phone = phoneNo;
      //             },
      //           ),
      //         ),
      //         SizedBox(
      //           height: MediaQuery.of(context).size.height / 2 - 90,
      //         ),
      //         BottomAppBar(
      //           child: GestureDetector(
      //             onTap: () {
      //               phoneValidator(phoneNo);
      //             },
      //             child: Container(
      //               width: MediaQuery.of(context).size.width - 50,
      //               height: 62.5,
      //               child: Center(
      //                 child: SizedBox(
      //                   width: 100,
      //                   child: isLoading
      //                       ? Center(
      //                           child: CircularProgressIndicator(
      //                           backgroundColor: Colors.blue,
      //                         ))
      //                       : Text(
      //                           'Submit',
      //                           style: TextStyle(
      //                               fontSize: 20,
      //                               color: Colors.white,
      //                               fontWeight: FontWeight.bold),
      //                           textAlign: TextAlign.center,
      //                         ),
      //                 ),
      //               ),
      //               color: Colors.deepOrange,
      //             ),
      //           ),
      //         )
      //       ],
      //     ),
      //   ),
      // ),
    );
  }
}
