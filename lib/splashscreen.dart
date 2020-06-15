import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/login.dart';
import 'package:nutshell/phone.dart';
import 'dart:async';

import 'package:nutshell/subscription.dart';
import 'package:nutshell/users.dart';

import 'database.dart';

class Splash extends StatefulWidget {
  @override
  _SplashState createState() => new _SplashState();
}

class _SplashState extends State<Splash> with SingleTickerProviderStateMixin {
  Animation<double> _mainLogoAnimation;
  AnimationController _mainLogoAnimationController;
bool _isLoading=false;
  @override
  void initState()  {
    super.initState();
    
     _mainLogoAnimationController = new AnimationController(
        duration: new Duration(milliseconds: 1900), vsync: this);
    _mainLogoAnimation = new CurvedAnimation(
        parent: _mainLogoAnimationController, curve: Curves.easeIn);
    _mainLogoAnimation.addListener(() => (this.setState(() {})));
    _mainLogoAnimationController.forward();
    existingUser();
  }


 Future existingUser() async {
     final Firestore _firestore = Firestore.instance;

 try{
       await new Future.delayed(const Duration(milliseconds: 1500));  

FirebaseUser user = await FirebaseAuth.instance.currentUser();
 print(user.toString());

  if(user!=null ){
     DocumentSnapshot _docSnap = await _firestore.collection("users").document(user.uid).get();
    
    if(_docSnap.data['subscription'])
    {
          
     Navigator.pushNamedAndRemoveUntil(context, "/paperback", (_) => false);
    }
    else
    {
      Navigator.pushNamed(context,"/subs");
    }
  } 
  else{
  await new Future.delayed(const Duration(milliseconds: 1000));
        Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);

// Navigator.of(context).push(
//                         new MaterialPageRoute(
//                             builder: (BuildContext context) => new Phone()
//                             )
//                             );  
  }
 }catch(e){
   print(e);
 }

 }


 
  // not using below code for splash screen
  Future goToLoginPage() async {
    await new Future.delayed(const Duration(milliseconds: 2000));
    String retVal = "error";

    final FirebaseAuth _auth = FirebaseAuth.instance;
    GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
      ],
    );
   // Users _user = Users();
    try {
      GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
      GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.getCredential(
          idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
      final AuthResult _authResult =
          await _auth.signInWithCredential(credential);
      if (_authResult.additionalUserInfo.isNewUser) {
        Navigator.pushNamedAndRemoveUntil(context, '/intro', (_) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, "/paperback", (_) => false);
      }
      //Navigator.of(context).pushAndRemoveUntil(new MaterialPageRoute(builder: (BuildContext context) => new IntroScreen()),(_)=> false);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return new Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color.fromRGBO(250, 112, 154, 1.0),
                Color.fromRGBO(254, 225, 64, 1.0)
              ]),
        ),
        child: new Center(
            child: new Opacity(
                opacity: 1.0 * _mainLogoAnimation.value,
                child: new Hero(
                    tag: 'logo',
                    child: new Image(
                      image: new AssetImage('assets/images/logo.png'),
                      width: MediaQuery.of(context).size.width - 100,
                    )))));
  }
}
