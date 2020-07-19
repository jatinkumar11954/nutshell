import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intro_slider/intro_slider.dart';
import 'package:intro_slider/slide_object.dart';
import 'package:nutshell/details.dart';
import 'package:nutshell/google.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/navigate.dart';
import 'package:nutshell/phone.dart';
import 'package:nutshell/subscription.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'constants.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

// List<Slide> slides = new List();

//   @override
//   void initState() {
//     super.initState();

//     slides.add(
//       new Slide(
//         widgetTitle: Center(child: Text( "New, innovative approach to general knowledge for school students",)),
//         centerWidget: Center(child: SvgPicture.asset("assets/int.svg",height: 500,width:400,fit:BoxFit.contain)),
//         styleDescription: TextStyle(
//             color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         //title: "ERASER",
//         // widgetDescription: SvgPicture.asset("assets/chicken.svg",height: 90,fit:BoxFit.contain),
//         // description:
//         //     "New, innovative approach to general knowledge for school students",
//         // pathImage: "assets/images/p1.png",

//         backgroundColor: Colors.greenAccent,
//       ),
//     );
//     slides.add(
//       new Slide(
//         styleDescription: TextStyle(
//             color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
//         // title: "PENCIL",
//         description:
//             "Captivating experience with refreshing topics, interesting stories and detailed answers",
//         pathImage: "assets/images/p2.png",
//         heightImage: 400,
//         widthImage: 400,
//         backgroundColor: Colors.blueAccent,
//       ),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//    return new IntroSlider(
//       slides: this.slides,
//     );
//   }
// }

class _IntroScreenState extends State<IntroScreen> {
  List<Slide> slides = new List();

  @override
  void initState() {
    super.initState();

    // slides.add(
    //  new Slide(
    //   widgetTitle: SvgPicture.asset("assets/images/INTRO1.svg"),
    //   heightImage: 400,
    //     widthImage: 400,
    //     // backgroundColor: Colors.blueAccent,
    //  )
    //  );
    slides.add(
      new Slide(
        // widgetTitle: Center(child: Text( "New, innovative approach to general knowledge for school students",)),
        centerWidget: Center(
            child: SvgPicture.asset("assets/images/INTRO1.svg",
                height: 350, width: 400, fit: BoxFit.contain)),
        backgroundColor: Color.fromRGBO(191, 30, 46, 1),
      ),
    );
    slides.add(
      new Slide(
        // widgetTitle: Center(child: Text( "New, innovative approach to general knowledge for school students",)),
        centerWidget: Center(
            child: SvgPicture.asset("assets/images/INTRO2.svg",
                height: 350, width: 400, fit: BoxFit.contain)),
        backgroundColor: Color.fromRGBO(191, 30, 46, 1),
      ),
    );
    slides.add(
      new Slide(
        // widgetTitle: Center(child: Text( "New, innovative approach to general knowledge for school students",)),
        centerWidget: Center(
            child: SvgPicture.asset("assets/images/INTRO3.svg",
                height: 350, width: 400, fit: BoxFit.contain)),
        backgroundColor: Color.fromRGBO(191, 30, 46, 1),
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

  Widget _buildPhone(Function onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.07,
          width: MediaQuery.of(context).size.width * 0.95,
          child: RaisedButton(
            color: Colors.white,
            onPressed: () {
              signInWithGoogle(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Image.asset('assets/images/google.png'),
                Text(
                  ' Login with Google',
                  style: TextStyle(
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                ),
              ],
            ),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0)),
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
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.07,
        width: MediaQuery.of(context).size.width * 0.95,
        child: RaisedButton(
          color: Colors.white,
          onPressed: () {
            print("clicked 1");
            Navigator.of(context).push(new MaterialPageRoute(
                builder: (BuildContext context) => new Phone()));
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Icon(
                Icons.phone,
                size: 35.0,
                color: Colors.blue,
              ),
              Text(
                'Login with Phone',
                style: TextStyle(
                    fontSize: 30.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
              ),
            ],
          ),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromRGBO(191, 30, 46, 1),
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              height: double.infinity,
              width: double.infinity,
              // decoration: BoxDecoration(
              //   gradient: LinearGradient(
              //       begin: Alignment.centerLeft,
              //       end: Alignment.centerRight,
              //       colors: [
              //         Color.fromRGBO(250, 112, 154, 1.0),
              //         Color.fromRGBO(254, 225, 64, 1.0)
              //       ]),
              // ),
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
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.01,
                    ),
                    Text('Hello \nThere.',
                        style: TextStyle(
                            fontSize: 70,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.15,
                    ),
                    _buildPhone(() => Navigator.of(context).push(
                        new MaterialPageRoute(
                            builder: (BuildContext context) => new Phone()))),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    // Center(
                    //   child: Text(
                    //     "OR",
                    //     style: Theme.of(context).textTheme.headline3,
                    //   ),
                    // ),
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
}
