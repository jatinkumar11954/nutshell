
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:nutshell/users.dart';

// import 'database.dart';

// class CurrentUser extends ChangeNotifier {
//   Users _currentUser = Users();

//   Users get getCurrentUser => _currentUser;

//   FirebaseAuth _auth = FirebaseAuth.instance;

//   Future<String> onStartUp() async {
//     String retVal = "error";

//     try {
//       FirebaseUser _firebaseUser = await _auth.currentUser();
//       if (_firebaseUser != null) {
//         _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
//         if (_currentUser != null) {
//           retVal = "success";
//         }
//       }
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }

//   Future<String> signOut() async {
//     String retVal = "error";

//     try {
//       await _auth.signOut();
//       _currentUser = Users();
//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }
//     return retVal;
//   }
// Future<String> signUpUser(String email, String password, String fullName) async {
//     String retVal = "error";
//     password = "123456789";
//     Users _user = Users();
//     try {
//       AuthResult _authResult =
//           await _auth.createUserWithEmailAndPassword(email: email, password: password);
//       _user.uid = _authResult.user.uid;
//       _user.email = _authResult.user.email;
//       _user.fname = fullName;
//       String _returnString = await OurDatabase().createUser(_user);
//       if (_returnString == "success") {
//         retVal = "success";
//       }
//     } on PlatformException catch (e) {
//       retVal = e.message;
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }

 
 

//   Future<String> loginUserWithGoogle() async {
//     String retVal = "error";
//     GoogleSignIn _googleSignIn = GoogleSignIn(
//       scopes: [
//         'email',
//         'https://www.googleapis.com/auth/contacts.readonly',
//       ],
//     );
//     Users _user = Users();

//     try {
//       GoogleSignInAccount _googleUser = await _googleSignIn.signIn();
//       GoogleSignInAuthentication _googleAuth = await _googleUser.authentication;
//       final AuthCredential credential = GoogleAuthProvider.getCredential(
//           idToken: _googleAuth.idToken, accessToken: _googleAuth.accessToken);
//       AuthResult _authResult = await _auth.signInWithCredential(credential);
//       if (_authResult.additionalUserInfo.isNewUser) {
//         _user.uid = _authResult.user.uid;
//         _user.email = _authResult.user.email;
//         _user.fname = _authResult.user.displayName;
//         OurDatabase().createUser(_user);
//       }
//       _currentUser = await OurDatabase().getUserInfo(_authResult.user.uid);
//       if (_currentUser != null) {
//         retVal = "success";
//       }
//     } on PlatformException catch (e) {
//       retVal = e.message;
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }
// }





import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nutshell/users.dart';

import 'database.dart';

class CurrentUser extends ChangeNotifier {
  Users _currentUser = Users();

  Users get getCurrentUser => _currentUser;

  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      FirebaseUser _firebaseUser = await _auth.currentUser();
      if (_firebaseUser != null) {
        _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
        if (_currentUser != null) {
          retVal = "success";
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signOut() async {
    String retVal = "error";

    try {
      await _auth.signOut();
      _currentUser = Users();
      retVal = "success";
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  Future<String> signUpUser(
      String email, String password, String fullName) async {
    String retVal = "error";
    password = "123456789";
    Users _user = Users();
    try {
      AuthResult _authResult = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      _user.uid = _authResult.user.uid;
      _user.email = _authResult.user.email;
      _user.fname = fullName;
      String _returnString = await OurDatabase().createUser(_user);
      if (_returnString == "success") {
        retVal = "success";
      }
    } on PlatformException catch (e) {
      retVal = e.message;
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<String> loginUserWithGoogle() async {
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
      AuthResult _authResult = await _auth.signInWithCredential(credential);
      String name;
      String email;
      String imageUrl;
// Add the following lines of code inside the
// signInWithGoogle method
      final FirebaseUser user =
          (await _auth.signInWithCredential(credential)) as FirebaseUser;
// Add the following lines after getting the user
// Checking if email and name is null
      assert(user.email != null);
      assert(user.displayName != null);
      assert(user.photoUrl != null);
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoUrl;
// Only taking the first part of the name, i.e., First Name
      if (name.contains(" ")) {
        name = name.substring(0, name.indexOf(" "));
      }
      if (_authResult.additionalUserInfo.isNewUser) {
        _user.uid = _authResult.user.uid;
        _user.email = _authResult.user.email;
        _user.fname = _authResult.user.displayName;
        OurDatabase().createUser(_user);
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
}
