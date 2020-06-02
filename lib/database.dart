import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:nutshell/users.dart';
class OurDatabase {
  final Firestore _firestore = Firestore.instance;

  Future<String> createUser(Users user) async {
    print("current user uid ${user.uid}");
    String retVal = "error";
FirebaseUser uid = await FirebaseAuth.instance.currentUser();
    print("firebase user uid ${uid.uid}");

    try {
      await _firestore.collection("users").document(uid.uid). setData({
        'OrderID': user.sID,
        'first Name': user.fname,
        'Last Name': user.lname,
        'email': user.email,
        'school': user.school,
        'class': user.grade,
        'city': user.city,
        'subscription':false,
        'phone': user.phone,
        'group': user.group,
        'accountCreated': Timestamp.now(),
      });
       print("Uploaded Info successfully in Firebase");
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<Users> getUserInfo(String uid) async {
    Users retVal = Users();

    try {
      print("called for data");
      print(uid);
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
      print("waiting jp");
      print(retVal.fname = _docSnapshot.data["first Name"]);
      retVal.uid = uid;
      retVal.sID = _docSnapshot.data["OrderId"];
      retVal.fname = _docSnapshot.data["first Name"];
      retVal.lname = _docSnapshot.data["Last Name"];
      retVal.email = _docSnapshot.data["email"];
      retVal.school = _docSnapshot.data["School"];
      retVal.grade = _docSnapshot.data["class"];
      retVal.city = _docSnapshot.data["City"];
      retVal.phone = _docSnapshot.data["phone"];
      retVal.group = _docSnapshot.data["group"];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
     
    
    } catch (e) {
      print("in catch");
      print(e);
    }
    print(retVal.fname);
    return retVal;
  }


//by JP


// Future<String> updateDetails(Users user) async {
//     String retVal = "error";

//     try {
//       await _firestore.collection("users").document(user.uid).updateData({
//         'OrderID': user.sID,
//         'first Name': user.fname,
//         'Last Name': user.lname,
//         'email': user.email,
//         'school': user.school,
//         'class': user.grade,
//         'city': user.city,
//         'phone': user.phone,
//         'group': user.group,
//         'accountCreated': Timestamp.now(),
//       });
//        print("Uploaded Info successfully in Firebase");
//       retVal = "success";
//     } catch (e) {
//       print(e);
//     }

//     return retVal;
//   }



  Future<String> freesubscription(String uid) async {
    String retVal = "error";

    try {
      await _firestore.collection("Subscribed").document(uid).setData({
        'OrderID': uid,
        // 'phone': user.phone,
        // 'group': user.group,
        'accountCreated': Timestamp.now(),
      });
       print("Uploaded subscribed Info successfully in Firebase");
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  }