import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:nutshell/details.dart';
import 'package:nutshell/google.dart';
import 'package:nutshell/home.dart';
import 'package:nutshell/navigate.dart';
import 'package:nutshell/phone.dart';
import 'package:nutshell/subscription.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'constants.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    slides.add(
      new Slide(
        styleDescription: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        //title: "ERASER",
        description:
            "New, innovative approach to general knowledge for school students",
        pathImage: "assets/images/p1.png",
         heightImage: 400,
        widthImage: 400,
        backgroundColor: Colors.greenAccent,
      ),
    );
    slides.add(
      new Slide(
        styleDescription: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        // title: "PENCIL",
        description:
            "Captivating experience with refreshing topics, interesting stories and detailed answers",
        pathImage: "assets/images/p2.png",
         heightImage: 400,
        widthImage: 400,
        backgroundColor: Colors.blueAccent,
      ),
    );
    slides.add(
      new Slide(
        styleDescription: TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        //title: "RULER",
        description:
            "Keep yourself updated about current and important events",
        pathImage: "assets/images/p3.png",
        heightImage: 400,
        widthImage: 400,
        backgroundColor: Colors.amberAccent,
      ),
    );
  }

  void onDonePress() {
    
    // Navigator.push(
    //     context, MaterialPageRoute(builder: (context) => Subscription()));
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => LoginScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return new IntroSlider(
      slides: this.slides,
      onDonePress: this.onDonePress,
    );
  }
}

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool checkValue = false;
  // SharedPreferences sharedPreferences;
  // @override
  // void initState() {
  //   super.initState();
  //   getCredential();
  // }

  Widget _buildPhone(Function onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 10.0),
        GestureDetector(
          onTap: onTap,
          child: Container(
            alignment: Alignment.centerLeft,
            decoration: kBoxDecorationStyle,
            height: 60.0,
            child: Center(
              child: Text(
                "Continue with Phone Number",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                  fontFamily: 'OpenSans',
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSocialBtn() {
    // return GestureDetector(
    //   onTap: onTap,
    //   child: Container(
    //     height: 60.0,
    //     width: 300.0,
    //     decoration: BoxDecoration(
    //       shape: BoxShape.rectangle,
    //       borderRadius: BorderRadius.circular(10),
    //       color: Colors.white,
    //       boxShadow: [
    //         BoxShadow(
    //           color: Colors.black26,
    //           offset: Offset(0, 2),
    //           blurRadius: 6.0,
    //         ),
    //       ],
    //       image: DecorationImage(
    //         image: logo,
    //       ),
    //     ),
    //   ),
    // );
    return Center(
      child: MaterialButton(
        textColor: Colors.white,
        color: Colors.white,

        // splashColor: Colors.white,
        onPressed: () {
          signInWithGoogle(context);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
        highlightElevation: 0,
        child: Padding(
          padding: EdgeInsets.all(10),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(
                  height: 60,
                  child: Image.asset(
                    'assets/images/google.png',
                  )),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Text(
                  'Sign in with Google',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Color.fromRGBO(250, 112, 154, 1.0),
                      Color.fromRGBO(254, 225, 64, 1.0)
                    ]),
              ),
              child: SingleChildScrollView(
                physics: AlwaysScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 40.0,
                  vertical: 120.0,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    new Hero(
                        tag: 'logo',
                        child: new Image(
                          image: new AssetImage('assets/images/logo.png'),
                          width: MediaQuery.of(context).size.width - 100,
                        )),
                    SizedBox(height: 60.0),
                    _buildPhone(() => 
                    Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Phone()
                            )
                            )
                            ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(
                      child: Text(
                        "OR",
                        style: Theme.of(context).textTheme.headline3,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Center(child: _buildSocialBtn()),
                  ],
                ),
              ),
            )),
      ),
    );
  }
//   _onChanged(bool value) async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       checkValue = value;
//       sharedPreferences.setBool("check", checkValue);
//       getCredential();
//     });
//   }

//   getCredential() async {
//     sharedPreferences = await SharedPreferences.getInstance();
//     setState(() {
//       checkValue = sharedPreferences.getBool("check");
//       if (checkValue != null) {
//         if (checkValue) {
//           _navigator();
//         }

//          else {
//           sharedPreferences.clear();
//         }
//       } else {
//         checkValue = false;
//       }
//     });
//   }

//   _navigator() {
//    checkFirstSeen();
//     // signInWithGoogle().whenComplete(() => Navigator.of(context)
//     //     .pushAndRemoveUntil( new MaterialPageRoute(builder: (context) => new Subscription()), (_) => false));
//   }
//   Future checkFirstSeen() async {
//         SharedPreferences prefs = await SharedPreferences.getInstance();
//         bool _seen = (prefs.getBool('seen') ?? false);

//         if (_seen) {
//         Navigator.of(context).pushReplacement(
//             new MaterialPageRoute(builder: (context) => new HomeScreen()));
//         } else {
//         await prefs.setBool('seen', true);
//         Navigator.of(context).pushReplacement(
//             new MaterialPageRoute(builder: (context) => new Subscription()));
//         }
//     }
}

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
//                         Navigator.of(context)
//                             .pushNamedAndRemoveUntil('/details', (_) => false);
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
//       Navigator.of(context).pushNamedAndRemoveUntil('/details', (_) => false);
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
