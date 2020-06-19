// import 'dart:convert';
// import 'package:http/http.dart' as http;
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// // import 'package:share/share.dart';
// // import 'package:url_launcher/url_launcher.dart';

// class AccountEditProfileScreen extends StatefulWidget {
//   AccountEditProfileScreen({Key key}) : super(key: key);

//   @override
//   _AccountEditProfileScreenState createState() => _AccountEditProfileScreenState();
// }

// class _AccountEditProfileScreenState extends State<AccountEditProfileScreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//     onWillPop: (){
//       Navigator.pushNamed(context,"/paperback");
//     },
//     child:Scaffold(
//       appBar: new AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         leading: new IconButton(
          
//           icon: new Icon(Icons.arrow_back,
//           color:Colors.red),
          
//           onPressed: (){
//             Navigator.pushNamed(context,"HomeScreen");
//           },
//         ),
        
//       ),
//       body:Container(
//         child: Column(
//       children: <Widget>[
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.1,
//           width: MediaQuery.of(context).size.width * 0.95,
//           child: Padding(
//             padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 20.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                   'Account EditProfileScreen',
//                   textAlign: TextAlign.left,
//                   style: TextStyle(
//                       fontSize: 30.0,
//                       fontFamily: 'Montserrat',
//                       fontWeight: FontWeight.w500),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   crossAxisAlignment: CrossAxisAlignment.center,
//                   children: <Widget>[
//                     IconButton(
//                       icon: Icon(
//                         Icons.edit,
//                         size: 26.0,
//                       ),
//                       tooltip: 'Edit Profile',
//                       onPressed: () {
//                         Navigator.pushNamed(context,"ProfileEdit");
//                       },
//                     ),
//                   ],
//                 )
//               ],
//             ),
//           ),
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.2,
//           width: MediaQuery.of(context).size.width * 1.0,
//           child: Padding(
//             padding: EdgeInsets.only(left: 25.0),
//             child: Row(
//               children: <Widget>[
//                 SizedBox(
//                   height: 120.0,
//                   width: 120.0,
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(110.0),
//                     child: Image.asset("images/userimg.png")
//                   ),
//                 ),
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height * 0.15,
//                   width: MediaQuery.of(context).size.width * 0.6,
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     crossAxisAlignment: CrossAxisAlignment.end,
//                     children: <Widget>[
//                       Padding(
//                         padding: EdgeInsets.only(top: 5.0),
//                         child: Text("akjsd",
//                           // global.UserName,
//                           textAlign: TextAlign.end,
//                           style: TextStyle(
//                               fontSize: 25.0,
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ),
//                       Divider(
//                         thickness: 4.0,
//                         endIndent: 4.0,
//                         color: Colors.redAccent,
//                       ),
//                       Padding(
//                         padding: EdgeInsets.only(left: 15.0),
//                         child: Text("jp@mail.id",
//                         // global.EmailId,
//                           textAlign: TextAlign.end,
//                           style: TextStyle(
//                               fontSize: 25.0,
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.w400),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//         Divider(
//           thickness: 3.0,
//         ),
//         SizedBox(
//             height: MediaQuery.of(context).size.height * 0.2,
//             width: MediaQuery.of(context).size.width * 0.98,
//             child: Padding(
//               padding: EdgeInsets.only(left: 35.0, right: 35.0),
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: <Widget>[
//                   Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: <Widget>[
//                         Text(
//                           'Mobile Number',
//                           textDirection: TextDirection.ltr,
//                           style: TextStyle(
//                               fontSize: 20.0,
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           'Referral Code',
//                           textDirection: TextDirection.ltr,
//                           style: TextStyle(
//                               fontSize: 20.0,
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.w500),
//                         ),
//                         Text(
//                           'DoDo Coins',
//                           textDirection: TextDirection.ltr,
//                           style: TextStyle(
//                               fontSize: 20.0,
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.w500),
//                         ),
//                       ]),
//                   Column(
//                       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                       crossAxisAlignment: CrossAxisAlignment.end,
//                       children: <Widget>[
//                         Text("9019",
//                           // global.MobileNumber.text,
//                           textDirection: TextDirection.ltr,
//                           style: TextStyle(
//                               fontSize: 20.0,
//                               fontFamily: 'Montserrat',
//                               fontWeight: FontWeight.w400),
//                         ),
//                         // Text(
//                         //   // global.ReferralCode,
//                         //   textDirection: TextDirection.ltr,
//                         //   style: TextStyle(
//                         //       fontSize: 20.0,
//                         //       fontFamily: 'Montserrat',
//                         //       fontWeight: FontWeight.w400),
//                         // ),
//                         // Row(
//                         //   children: <Widget>[
//                         //     SizedBox(
//                         //         height: 25.0,
//                         //         width: 25.0,
//                         //         child: Image.asset('images/account_dodo.png')),
//                         //     Padding(
//                         //       padding: EdgeInsets.only(left: 30.0),
//                         //       child: Text(
//                         //         // global.coins,
//                         //         textDirection: TextDirection.ltr,
//                         //         style: TextStyle(
//                         //             fontSize: 20.0,
//                         //             fontFamily: 'Montserrat',
//                         //             fontWeight: FontWeight.w400),
//                         //       ),
//                         //     ),
//                         //   ],
//                         // )
//                       ])
//                 ],
//               ),
//             )),
//         Divider(
//           thickness: 3.0,
//         ),
//         SizedBox(
//           height: MediaQuery.of(context).size.height * 0.2,
//           width: MediaQuery.of(context).size.width * 0.98,
//           child: Padding(
//             padding: EdgeInsets.only(left: 35.0, right: 35.0),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: <Widget>[
//                 Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                   children: <Widget>[
//                     Text(
//                       'Share and refer',
//                       textDirection: TextDirection.ltr,
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                     Text(
//                       'Contact Us',
//                       textDirection: TextDirection.ltr,
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                      Text(
//                       'Sign out',
//                       textDirection: TextDirection.ltr,
//                       style: TextStyle(fontSize: 20.0),
//                     ),
//                   ],
//                 ),
//                 // Column(
//                 //   crossAxisAlignment: CrossAxisAlignment.start,
//                 //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 //   children: <Widget>[
//                 //     IconButton(
//                 //       icon: Icon(
//                 //         Icons.share,
//                 //         size: 26.0,
//                 //       ),
//                 //       tooltip: 'Share App',
//                 //       onPressed: () {
//                 //         // setState(() {
//                 //         //      });
//                 //          Share.share("meet me on LinkedIN https://in.linkedin.com/in/jaya-prakash-veldanda-756b48179");
                    
//                 //       },
//                 //     ),
//                 //     IconButton(
//                 //       icon: Icon(
//                 //         Icons.phone,
//                 //         size: 26.0,
//                 //       ),
//                 //       tooltip: 'Contact us',
//                 //       onPressed: ()async {
//                 //         print("clicked for call");
//                 //         // setState(() {});
//                 //         if (await canLaunch("tel:919010590693")) {
//                 //        await launch("tel:919010590693");
//                 //         }
//                 //       },
//                 //     ),
//                 //      IconButton(
//                 //       icon: Icon(
//                 //         Icons.phone,
//                 //         size: 26.0,
//                 //       ),
//                 //       tooltip: 'Contact us',
//                 //       onPressed: ()async {
//                 //         print("clicked for call");
//                 //         // setState(() {});
//                 //         if (await canLaunch("tel:919010590693")) {
//                 //        await launch("tel:919010590693");
//                 //         }
//                 //       },
//                 //     ),
//                 //   ],
//                 // )
//               ],
//             ),
//           ),
//         )
//       ],
//     ))
//     )
//     );
//   }
// }





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
// TextEditingController _emailcontroller = TextEditingController();
// TextEditingController _phonecontroller = TextEditingController();
// TextEditingController _citycontroller = TextEditingController();

//  _fnamecontroller = 
//  _lnamecontroller = 
//  _schoolcontroller = 
//  _classcontroller = 
//  _emailcontroller =
//  _phonecontroller = 
// _citycontroller =  shd update values too display while updating





class EditProfileScreen extends StatefulWidget {
  @override
  _EditProfileScreenState createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
 
  bool _validate = false;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
 
  
  Users _currentUser = Users();

  Users get getCurrentUser => _currentUser;
  bool isLoading=false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      setState(() {
        isLoading=true;
        _dropformSelected=_currentUser.group==null?"Select Group":_currentUser.group.toString();
       

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
        isLoading=false;
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


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final text = TextEditingController();



  //  void callSnackBar(String msg,[int er])
  // {
    
  //     // msg="There is no record with this user, please register first by clicking Register";
  //   //  final SnackBar= new SnackBar(content: null)
  //     final SnackBar=new SnackBar(
  //     content: new Text(msg),
  //     duration: new Duration(seconds: 3),
  //   //   action: new SnackBarAction(label: "Register",
  //   //   onPressed: (){
  //   //     Navigator.pushNamed(context, "Register");
  //   //   },),
  //   );
  //    _scaffoldKey.currentState.showSnackBar(SnackBar);
  //   }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Colors.white,
      //   elevation: 0.0,
      //   iconTheme: IconThemeData(
      //     color: Colors.black,
      //     size: 80.0,
      //   ),
      // ),
       appBar: AppBar(
          title: Text("Update/Edit User Details",style: TextStyle(color: Colors.black),),
          backgroundColor:Colors.orange[300],
          leading: new IconButton(
          icon: Icon(
                        Icons.arrow_back,
                        size: 30.0,
                        color: Colors.black,
                      ),
                      tooltip: 'back',
                      onPressed: () {
                        Navigator.pushNamed(context,"/account");
                    
          },
        ),
        ),
      body: isLoading?
      Center(child: CircularProgressIndicator()): Center(
        child: new Form(
          key: _formKey,
          autovalidate: _validate,
          child: FormUI(),
        ),
      ),
    );
  }

  // Widget GroupUi() {
  //   bool selected = false;
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         child: Title(
  //           color: Colors.black,
  //           child: Text("Select Group"),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: (){
  //           _currentUser.group = 'GroupA';
  //            setState(() {
  //             selected = true;
  //           });
  //         },
  //                 child: Container(
  //                   color: selected == true ? Colors.amber : Colors.grey,
  //           height: MediaQuery.of(context).size.height / 3,
  //           width: MediaQuery.of(context).size.width - 100,
  //           child: Column(
  //             children: <Widget>[
  //               Text("Group A", style: Theme.of(context).textTheme.headline3),
  //               Text("Suitable for students of ages 9-12")
  //             ],
  //           ),
  //         ),
  //       ),
        
  //       GestureDetector(
  //         onTap: () {
  //           _currentUser.group = 'GroupB';
  //           setState(() {
  //             selected = true;
  //           });
  //         },
  //                 child: Container(
  //                   color: selected == true ? Colors.amber : Colors.grey,
  //           height: MediaQuery.of(context).size.height / 3,
  //           width: MediaQuery.of(context).size.width - 100,
  //           child: Column(
  //             children: <Widget>[
  //               Text("Group B", style: Theme.of(context).textTheme.headline3),
  //               Text("Suitable for students of ages 13-18")
  //             ],
  //           ),
  //         ),
  //       ),
  //       BottomAppBar(
  //         child: GestureDetector(
  //           onTap: () {
  //             sendToServer();
  //             //  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
  //           },
  //           child: Container(
  //             width: MediaQuery.of(context).size.width - 50,
  //             height: 62.5,
  //             child: Center(
  //               child: SizedBox(
  //                 width: 100,
  //                 child: Text(
  //                   'Submit',
  //                   style: TextStyle(
  //                       fontSize: 20,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //             color: Colors.deepOrange,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }
var _dropforms= [
   'Select Group','Group-A','Group-B'
  ]; 
  var _dropformSelected;

  

  Widget FormUI() {
     
    _currentUser.sID = sID;
     bool selected = false;
    return ListView(
       children: <Widget>[
      Text("\n"),
     Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
       Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            // SizedBox(height: 50,width: 50,),
            SizedBox(
              width: 140,
              child: TextFormField(
                  controller: _fnamecontroller,
                  // autovalidate: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Enter First Name',hintText: _currentUser.fname.toString()),
                  validator: validateName,
                  onSaved: (String value) {
                    _currentUser.fname = value;
                  }),
            ),
            SizedBox(
              width: 140,
              child: TextFormField(
                  controller: _lnamecontroller,
                  // autovalidate: true,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Enter Last Name',hintText: _currentUser.lname.toString()),
                  validator: validateName,
                  onSaved: (String value) {
                    _currentUser.lname = value;
                  }),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 320,
          child: TextFormField(
              controller: _schoolcontroller,
              // autovalidate: true,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Enter School Name',hintText: _currentUser.school.toString()),
              validator: validateSchool,
              onSaved: (String value) {
                _currentUser.school = value;
              }),
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 320,
          child: TextFormField(
              controller: _classcontroller,
              // autovalidate: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Class',),
              validator: validateClass,
              onSaved: (String value) {
                _currentUser.grade = value;
              }),
        ),
        // Padding(padding: EdgeInsets.all(10)),
        // SizedBox(
        //   width: 320,
        //   child: TextFormField(
        //       controller: _emailcontroller,
        //       autovalidate: true,
        //       keyboardType: TextInputType.emailAddress,
        //       decoration: InputDecoration(labelText: 'Enter Email Address'),
        //       validator: validateEmail,
        //       onSaved: (String value) {
        //         _currentUser.email = value;
        //         email = value;
        //       }),
        // ),
        Padding(padding: EdgeInsets.all(10)),
        // SizedBox(
        //   width: 320,
        //   child: TextFormField(
        //       controller: _citycontroller,
        //       autovalidate: true,
        //       keyboardType: TextInputType.text,
        //       decoration: InputDecoration(labelText: 'Enter City',hintText: _currentUser.city.toString()),
        //       validator: validateCity,
        //       onSaved: (String value) {
        //         _currentUser.city = value;
        //       }),
        // ),
      //   Padding(padding: EdgeInsets.all(10)),
      //   SizedBox(
      //     width: 320,
      //     child: TextFormField(
      //         controller: _phonecontroller,
      //         autovalidate: true,
      //         keyboardType: TextInputType.number,
      //         decoration: InputDecoration(
      //             labelText: 'Enter Phone Number', prefix: Text("+91")),
      //         validator: validatePhone,
      //         onSaved: (String value) {
      //           _currentUser.phone = value;
      //           phone = value;
      //         }),
      //   ),
      //   Padding(padding: EdgeInsets.all(10)),
      //   SizedBox( 
      //     width: 320,
      //     child: Column(
      //       children: <Widget>[
              
      //         Text("Select Group",style: TextStyle(color:Colors.black,fontSize: 20.0),),
      //         Text("\n1. Group A Suitable for students of ages 9-12\n2. Suitable for students of ages 13-1"),
      //         // Text("Suitable for students of ages 9-12")"),)
      //         // Padding.EdgeInsets.only()

      //       ],
      //     ),
      //     // Text("Select Group",),

      //     // 1. Group A Suitable for students of ages 9-12\n2. Suitable for students of ages 13-1"),
      // //         Text("Suitable for students of ages 9-12")"),
      //     // height: MediaQuery.of(context).size.height / 6,
      //   ),
        // Padding(padding: EdgeInsets.only(left:10)),
        //  SizedBox( 
        //   width: 320,
        //                 child:DropdownButton<String>(
        //             items: _dropforms.map((String dropDownStringItem)
        //             {
        //                return DropdownMenuItem<String>(
        //                   value: dropDownStringItem,
        //                   child: Text(dropDownStringItem),

        //                );
        //             }).toList(),
        //             onChanged: (String newValueSelected){
        //               setState(() {
        //                  _currentUser.group = newValueSelected;
        //                 this._dropformSelected =newValueSelected;
        //               });
        //             },
        //             value: _dropformSelected,
        //             ),
        //       ),
              Padding(padding: EdgeInsets.all(20)),
      ],
    ),
    // Container(
    //     child: Title(
    //       color: Colors.black,
    //       child: Text("Select Group"),
    //     ),
    //   ),
    // Text("Select Group"),
      // GestureDetector(
      //   onTap: (){
      //     _currentUser.group = 'GroupA';
      //      setState(() {
      //       selected = true;
      //     });
      //   },
      //           child: Container(
      //             color: selected == true ? Colors.amber : Colors.grey,
      //     height: MediaQuery.of(context).size.height / 3,
      //     width: MediaQuery.of(context).size.width - 100,
      //     child: Column(
      //       children: <Widget>[
      //         Text("Group A", style: Theme.of(context).textTheme.headline3),
      //         Text("Suitable for students of ages 9-12")
      //       ],
      //     ),
      //   ),
      // ),
      
      // GestureDetector(
      //   onTap: () {
      //     _currentUser.group = 'GroupB';
      //     setState(() {
      //       selected = true;
      //     });
      //   },
      //           child: Container(
      //             color: selected == true ? Colors.amber : Colors.grey,
      //     height: MediaQuery.of(context).size.height / 3,
      //     width: MediaQuery.of(context).size.width - 100,
      //     child: Column(
      //       children: <Widget>[
      //         Text("Group B", style: Theme.of(context).textTheme.headline3),
      //         Text("Suitable for students of ages 13-18")
      //       ],
      //     ),
      //   ),
      // ),
      BottomAppBar(
        child: GestureDetector(
          onTap: () {
              sendToServer();
           
            // Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 62.5,
            child: Center(
              child: SizedBox(
                width: 100,
                child: Text(
                  'Update',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            color: Colors.deepOrange,
          ),
        ),
      )
       ]
    );
  }

  sendToServer() async {
    // Users _user = Users();
    if (_formKey.currentState.validate()) {
      // No any error in validation
      _formKey.currentState.save();
       Navigator.pushNamed(context,"/account");
      print("CLicked successfully");
      OurDatabase().updateDetails(_currentUser);   
      print("updated user user");
      // Navigator.push(
      //   context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // Navigator.pushNamed(context, "/dummy");
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
