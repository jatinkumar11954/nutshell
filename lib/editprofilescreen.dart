import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/orderConfirmation.dart';
import 'package:nutshell/users.dart';

import 'database.dart';
import 'subscription.dart';

String phone;
String email;

TextEditingController _fnamecontroller = TextEditingController();
TextEditingController _lnamecontroller = TextEditingController();
TextEditingController _schoolcontroller = TextEditingController();
TextEditingController _classcontroller = TextEditingController();

class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  bool _validate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  Users _currentUser = Users();

  Users get getCurrentUser => _currentUser;
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      setState(() {
        isLoading = true;
        _dropformSelected = _currentUser.group == null
            ? "Select Group"
            : _currentUser.group.toString();
      });
      FirebaseUser _firebaseUser = await _auth.currentUser();
      print(_firebaseUser.email);
      if (_firebaseUser != null) {
        print(_firebaseUser.uid);
        _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
        if (_currentUser != null) {
          retVal = "success";
          print("in if ");
          print(_currentUser.phone);
          setState(() {
            isLoading = false;
          });
        }
      }
    } catch (e) {
      print(e);
    }
    return retVal;
  }

  @override
  void initState() {
    super.initState();
    onStartUp();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final text = TextEditingController();
  bool enable_btn = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 5.0,
        title: Text(
          "Update/Edit User Details",
          style: TextStyle(color: Colors.black),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        backgroundColor: Colors.white,
        leading: new IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 30.0,
            color: Colors.black,
          ),
          tooltip: 'back',
          onPressed: () {
            Navigator.pushNamed(context, "/account");
          },
        ),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Center(
              child: new Form(
                key: _formKey,
                autovalidate: _validate,
                child: FormUI(),
              ),
            ),
    );
  }

  var _dropforms = ['Select Group', 'Group-A', 'Group-B'];
  var _dropformSelected;

  Widget FormUI() {
    _currentUser.sID = sID;
    bool selected = false;
    return ListView(children: <Widget>[
      Container(
        padding: EdgeInsets.only(left: 25.0),
        child:
            // Text("\n"),
            Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Text(
              'Update \nDetails',
              style: TextStyle(
                  fontSize: 75.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.redAccent[700]),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                  controller: _fnamecontroller,
                  // autovalidate: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Enter your First Name',
                      hintText: _currentUser.fname.toString()),
                  validator: validateName,
                  onSaved: (String value) {
                    _currentUser.fname = value;
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                  controller: _lnamecontroller,
                  // autovalidate: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Enter your Last Name',
                      hintText: _currentUser.lname.toString()),
                  validator: validateName,
                  onSaved: (String value) {
                    _currentUser.lname = value;
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                  controller: _schoolcontroller,
                  // autovalidate: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15.0)),
                      labelText: 'Enter your Institution',
                      hintText: _currentUser.school.toString()),
                  validator: validateSchool,
                  onSaved: (String value) {
                    _currentUser.school = value;
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                  // controller: _classcontroller,
                  // autovalidate: true,
                  // keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    labelText: 'Enter your Email',
                  ),
                  // validator: validateClass,
                  onSaved: (String value) {
                    _currentUser.email = value;
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: TextFormField(
                  maxLength: 10,
                  // controller: _classcontroller,
                  autovalidate: true,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(15.0)),
                    labelText: 'Enter your Phone Number',
                  ),
                  validator: (String txt) {
                    if (txt.length == 10) {
                      Future.delayed(Duration.zero).then((_) {
                        setState(() {
                          enable_btn = true;
                        });
                      });
                    } else {
                      enable_btn = false;
                    }
                  },
                  onSaved: (String value) {
                    _currentUser.phone = value;
                  }),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.02),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.85,
              child: RaisedButton(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0)),
                onPressed: enable_btn == true
                    ? () {
                        sendToServer();
                      }
                    : null,
                color: Colors.deepOrange,
                child: Text(
                  "Update",
                  style: TextStyle(
                      fontSize: 20.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    ]);
  }

  sendToServer() async {
    // Users _user = Users();
    if (_formKey.currentState.validate()) {
      // No any error in validation
      _formKey.currentState.save();
      Navigator.pushNamed(context, "/account");
      print("CLicked successfully");
      OurDatabase().updateDetails(_currentUser);
      print("updated user user");
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}

String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length <= 2) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

String validateSchool(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length <= 2) {
    return "School Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Special characters not allowed";
  }
  return null;
}

String validateClass(String value) {
  String pattern = '([0-2]{2}|[123456789])';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Class is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Class must be between 1-12";
  }
  return null;
}

String validateCity(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "City is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Please enter a valid City";
  }
  return null;
}

// String validateEmail(String value) {
//   String pattern =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length == 0) {
//     return "Email is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Invalid Email";
//   } else {
//     return null;
//   }
// }

// String validatePhone(String value) {
// // Indian Mobile number are of 10 digit only
//   if (value.length != 10)
//     return 'Mobile Number must be of 10 digit';
//   else
//     return null;
// }
