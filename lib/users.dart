import 'package:cloud_firestore/cloud_firestore.dart';

class Users{
  String sID;
   String fname;
  String lname;
  String school;
  String grade;
  String email;
  String city;
  String uid;
  String phone;
  String group;
  String photoUrl;
  String subPlan;
  String pinCode;
  Timestamp accountCreated;

Users({
  this.sID,
  this.fname,
  this.lname,
  this.school,
  this.grade,
  this.email,
  this.city,
  this.uid,
  this.phone,
  this.group,
  this.accountCreated,
  this.photoUrl,
  this.pinCode,
  this.subPlan
});

}

