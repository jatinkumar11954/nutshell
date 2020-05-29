import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nutshell/users.dart';
class OurDatabase {
  final Firestore _firestore = Firestore.instance;

  Future<String> createUser(Users user) async {
    String retVal = "error";

    try {
      await _firestore.collection("users").document(user.uid).setData({
        'OrderID': user.sID,
        'first Name': user.fname,
        'Last Name': user.lname,
        'email': user.email,
        'school': user.school,
        'class': user.grade,
        'city': user.city,
        'phone': user.phone,
        'group': user.group,
        'accountCreated': Timestamp.now(),
      });
      retVal = "success";
    } catch (e) {
      print(e);
    }

    return retVal;
  }

  Future<Users> getUserInfo(String uid) async {
    Users retVal = Users();

    try {
      DocumentSnapshot _docSnapshot = await _firestore.collection("users").document(uid).get();
      retVal.uid = uid;
      retVal.sID = _docSnapshot.data["OrderId"];
      retVal.fname = _docSnapshot.data["first Name"];
      retVal.lname = _docSnapshot.data["Last Name"];
      retVal.email = _docSnapshot.data["email"];
      retVal.school = _docSnapshot.data["School"];
      retVal.grade = _docSnapshot.data["Class"];
      retVal.city = _docSnapshot.data["City"];
      retVal.phone = _docSnapshot.data["Phone"];
      retVal.group = _docSnapshot.data["Group"];
      retVal.accountCreated = _docSnapshot.data["accountCreated"];
    
    } catch (e) {
      print(e);
    }

    return retVal;
  }
  }