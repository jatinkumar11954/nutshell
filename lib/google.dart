import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutshell/database.dart';
import 'package:nutshell/users.dart';

import 'navigate.dart';

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

// Future<String> signInWithGoogle() async {
//   final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
//   final GoogleSignInAuthentication googleSignInAuthentication =
//       await googleSignInAccount.authentication;

//   final AuthCredential credential = GoogleAuthProvider.getCredential(
//     accessToken: googleSignInAuthentication.accessToken,
//     idToken: googleSignInAuthentication.idToken,
//   );

//   final AuthResult authResult = await _auth.signInWithCredential(credential);
//   final FirebaseUser user = authResult.user;

//   assert(!user.isAnonymous);
//   assert(await user.getIdToken() != null);

//   final FirebaseUser currentUser = await _auth.currentUser();
//   assert(user.uid == currentUser.uid);

//   return 'signInWithGoogle succeeded: $user';
// }
Users _currentUser = Users();

Users get getCurrentUser => _currentUser;
Future<String> signInWithGoogle(BuildContext context) async {
  String retVal = "error";
  GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
    ],
  );
  Users _user = Users();

  try {
    GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
    GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
    final AuthCredential credential = GoogleAuthProvider.getCredential(
        idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);

   final AuthResult _authResult = await _auth.signInWithCredential(credential);
    if (_authResult.additionalUserInfo.isNewUser) {
      _user.uid = _authResult.user.uid;
      _user.email = _authResult.user.email;
      _user.fname = _authResult.user.displayName;
      OurDatabase().createUser(_user);
      Navigator.pushNamedAndRemoveUntil(context, '/subs', (_)=> false);
    }
    else {
       Navigator.pushNamedAndRemoveUntil(context, "/home",  (_)=> false);
    }
    _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
    if (_currentUser != null) {
      retVal = "success";
    }
  } on PlatformException catch (e) {
    retVal = e.message;
  } catch (e) {
    print(e);
  }

  return retVal;
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Sign Out");
}
