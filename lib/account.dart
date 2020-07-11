import 'dart:convert';
import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutshell/bottomNav.dart';
import 'package:nutshell/database.dart';
import 'package:nutshell/google.dart';
import 'package:nutshell/users.dart';
import 'currentUser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

File _image;
final picker = ImagePicker();
String _myValue;
String _description;
String postUrl;
String cardUrl;
String _category;
String _group;
final GlobalKey<FormState> formKey = GlobalKey<FormState>();

class _AccountState extends State<Account> {
  Future getImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      _image = File(image.path);
      print('Image Path $_image');
    });
  }

  bool validateAndSave() {
    final form = formKey.currentState;

    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  Future uploadPic(BuildContext context) async {
    String fileName = _image.path;

    final StorageReference postImageRef =
        FirebaseStorage.instance.ref().child("profile");

    var timeKey = new DateTime.now();

    final StorageUploadTask uploadTask =
        postImageRef.child(timeKey.toString() + ".png").putFile(_image);
    var PostUrl = await (await uploadTask.onComplete).ref.getDownloadURL();
    postUrl = PostUrl.toString();
    print("Post Url =" + postUrl);
    saveToDatabase(postUrl);
    // }
    setState(() {
      print("Profile Picture uploaded");
      Scaffold.of(context)
          .showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
    });
  }

  void saveToDatabase(String url) {
    var dbTimeKey = new DateTime.now();
    var formatDate = new DateFormat('MMM d, yyyy');
    var formatTime = new DateFormat('EEEE, hh:mm aaa');

    String date = formatDate.format(dbTimeKey);
    String time = formatTime.format(dbTimeKey);

    DatabaseReference ref = FirebaseDatabase.instance.reference();

    var data = {
      "postImage": postUrl,
      "title": _myValue,
      "date": date,
      "time": time,
      "description": _description,
      "category": _category,
    };
    ref.child("profile").push().set(data);
  }

  Users _currentUser = Users();

  Users get getCurrentUser => _currentUser;
  bool isLoading = false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      setState(() {
        isLoading = true;
      });
      FirebaseUser _firebaseUser = await _auth.currentUser();
      // print(_firebaseUser.email);
      if (_firebaseUser != null) {
        // print(_firebaseUser.uid);
        _currentUser = await OurDatabase().getUserInfo(_firebaseUser.uid);
        if (_currentUser != null) {
          retVal = "success";
          print("in if ");
          print(_currentUser.phone);
          print(_currentUser.subPlan);
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
    // TODO: implement initState
    super.initState();
    onStartUp();
  }

  @override
  Widget build(BuildContext context) {
    // print("jp"+_currentUser.photoUrl.toString());
    return WillPopScope(
        onWillPop: () {
          Navigator.pushNamed(context, "/paperback");
        },
        child: Scaffold(
            // bottomNavigationBar: bottomBar(context, 2),
            bottomNavigationBar: PersistentNavBar(),
            appBar: new AppBar(
              actions: <Widget>[
                IconButton(
                  icon: Icon(
                    Icons.mode_edit,
                    size: 35.0,
                    color: Colors.black,
                  ),
                  tooltip: 'Edit Profile',
                  onPressed: () {
                    Navigator.pushNamed(context, "/editprofile");
                  },
                ),
              ],
              // title: new Text("Account Details",style: TextStyle(color:Colors.black,fontSize: 30.0),),
              backgroundColor: Colors.white,
              elevation: 5.0,
            ),
            body: isLoading
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Container(
                    child: Column(
                      children: <Widget>[
                        ListTile(
                          contentPadding:
                              EdgeInsets.fromLTRB(0, 10.0, 0.0, 10.0),
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Align(
                                alignment: Alignment.topLeft,
                                child: CircleAvatar(
                                  radius: 70,
                                  backgroundImage: NetworkImage(
                                      _currentUser.photoUrl.toString()),
                                  backgroundColor: Color(0xff476cfb),
                                  child: ClipOval(
                                      child: new SizedBox(
                                          width: 180.0,
                                          height: 180.0,
                                          child: (_image != null)
                                              ? Image.file(
                                                  _image,
                                                  fit: BoxFit.fill,
                                                )
                                              : null
                                          // : Icon(Icons.account_circle,
                                          //     size: 70))
                                          )),
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 60.0),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.add_a_photo,
                                    size: 30.0,
                                  ),
                                  onPressed: () {
                                    getImage();
                                  },
                                ),
                              ),
                              Wrap(
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.only(top: 15.0),
                                    child: Text(
                                      _currentUser.fname.toString() + " ",
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 20.0,
                                          fontFamily: 'Montserrat',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                  Text(
                                    _currentUser.group.toString(),
                                    style: TextStyle(
                                        fontSize: 20.0,
                                        fontFamily: 'Montserrat',
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Center(
                          child: RaisedButton(
                            color: Colors.black,
                            onPressed: () {
                              uploadPic(context);
                            },
                            elevation: 4.0,
                            splashColor: Colors.blueGrey,
                            child: Text(
                              'Save',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            ),
                          ),
                        ),
                        Divider(
                          height: 45,
                          thickness: 2.0,
                          color: Colors.orange,
                        ),
                        Container(
                          padding: new EdgeInsets.all(5.0),
                        ),
                        SizedBox(
                            child: Column(children: <Widget>[
                          // ListTile(
                          //   title: new Text('About Us'),
                          //   leading: new Icon(Icons.chat_bubble_outline),
                          //   onTap: () {
                          //     Navigator.pushNamed(context, "/about");
                          //   },
                          // ),
                          ListTile(
                            title: new Text('Pricing Plan'),
                            leading: new Icon(Icons.account_balance_wallet),
                            onTap: () {
                              Navigator.pushNamed(context, "/pricing");
                            },
                          ),
                          ListTile(
                            title: new Text('Contact Us'),
                            leading: new Icon(Icons.call),
                            onTap: () {
                              Navigator.pushNamed(context, "/contact");
                            },
                          ),
                          ListTile(
                            title: new Text('Help'),
                            leading: new Icon(Icons.assignment),
                            subtitle: Text("Privacy, Refund, TnC, About Us"),
                            onTap: () {
                              Navigator.pushNamed(context, "/help");
                            },
                          ),
                          ListTile(
                            title: new Text(
                              'Logout',
                              style: TextStyle(fontSize: 20.0
                                  // color:Colors.deepOrange
                                  ),
                            ),
                            leading: new Icon(
                              Icons.settings_power,
                              //  color: Colors.deepOrange,
                            ),
                            onTap: () {
                              showAlertDialog(context);
                            },
                          ),
                        ])),
                      ],
                    ),
                  )));
  }
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("No"),
    onPressed: () {
      Navigator.pop(context);
    },
  );
  Widget continueButton = FlatButton(
    child: Text("Yes"),
    onPressed: () {
      signOutGoogle();
      Navigator.of(context).pushNamedAndRemoveUntil('/Login', (_) => false);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(
      "Logout",
    ),
    content: Text("Do you want to logout?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

@override
Widget build(BuildContext context) {
  // TODO: implement build
  throw UnimplementedError();
}
