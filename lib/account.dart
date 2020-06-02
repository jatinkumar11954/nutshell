// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:nutshell/google.dart';

// class Account extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//         color: Colors.white,
//         child: ListView(
//           children: [
//             ListTile(
//               title: Text("Edit Profile"),
//               onTap: (){
//                 Navigator.pushNamed("/");
//               },
//             ),
//             ListTile(
//               title: Text("Manage Subscriptions"),
//             ),
//             ListTile(
//               title: Text("About Us"),
//             ),
//             ListTile(
//               title: Text("Contact Us"),
//             ),
//             GestureDetector(
//               onTap: () {
//                 showAlertDialog(context);
               
//               },
//               child: ListTile(
//                 title: Text("Logout"),
//               ),
//             ),
//           ],
//         ));
//   }
// }

// showAlertDialog(BuildContext context) {
//   // set up the buttons
//   Widget cancelButton = FlatButton(
//     child: Text("No"),
//     onPressed: () {
//       Navigator.pop(context);
//     },
//   );
//   Widget continueButton = FlatButton(
//     child: Text("Yes"),
//     onPressed: () { signOutGoogle();
//                 Navigator.of(context)
//                     .pushNamedAndRemoveUntil('/Login', (_) => false);},
//   );

//   // set up the AlertDialog
//   AlertDialog alert = AlertDialog(
//     title: Text("Logout"),
//     content: Text("Do you want to logout?"),
//     actions: [
//       cancelButton,
//       continueButton,
//     ],
//   );

//   // show the dialog
//   showDialog(
//     context: context,
//     builder: (BuildContext context) {
//       return alert;
//     },
//   );
// }






import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nutshell/database.dart';
import 'package:nutshell/google.dart';
import 'package:nutshell/users.dart';
import 'currentUser.dart';
// import 'package:share/share.dart';
// import 'package:url_launcher/url_launcher.dart';

class Account extends StatefulWidget {
  Account({Key key}) : super(key: key);

  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {


  Users _currentUser = Users();

  Users get getCurrentUser => _currentUser;
bool isLoading=false;
  FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String> onStartUp() async {
    String retVal = "error";

    try {
      setState(() {
        isLoading=true;
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

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
    onWillPop: (){
      Navigator.pushNamed(context,"/home");
    },
    child:Scaffold(
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
                        Navigator.pushNamed(context,"/editprofile");
                    
          },
        ),
        ],
        title: new Text("Account Details",style: TextStyle(color:Colors.black,fontSize: 30.0),),
        backgroundColor: Colors.white,
        elevation: 0.0,
        
        // leading: new IconButton(
          
        //   icon: Icon(
        //                 Icons.edit,
        //                 size: 30.0,
        //                 color: Colors.black,
        //               ),
        //               tooltip: 'Edit Profile',
        //               onPressed: () {
        //                 Navigator.pushNamed(context,"/editprofile");
                    
        //   },
        // ),
        //  IconButton(
        //               icon: Icon(
        //                 Icons.edit,
        //                 size: 26.0,
        //               ),
        //               tooltip: 'Edit Profile',
        //               onPressed: () {
        //                 Navigator.pushNamed(context,"/editprofile");
        //               },
        //             ),
        
      ),
      body:
      isLoading?
      Center(child: CircularProgressIndicator(),):
      ListView(
        // child: Column(
      children: <Widget>[
        // SizedBox(
        //   height: MediaQuery.of(context).size.height * 0.1,
        //   width: MediaQuery.of(context).size.width * 0.95,
        //   child: Padding(
        //     padding: EdgeInsets.only(top: 10.0, left: 30.0, right: 20.0),
        //     child: Row(
        //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: <Widget>[
        //         // Text(
        //         //   'Account Details',
        //         //   textAlign: TextAlign.left,
        //         //   style: TextStyle(
        //         //       fontSize: 30.0,
        //         //       fontFamily: 'Montserrat',
        //         //       fontWeight: FontWeight.w500),
        //         // ),
        //         Row(
        //           mainAxisAlignment: MainAxisAlignment.start,
        //           crossAxisAlignment: CrossAxisAlignment.center,
        //           children: <Widget>[
        //             IconButton(
        //               icon: Icon(
        //                 Icons.edit,
        //                 size: 26.0,
        //               ),
        //               tooltip: 'Edit Profile',
        //               onPressed: () {
        //                 Navigator.pushNamed(context,"/editprofile");
        //               },
        //             ),
        //           ],
        //         )
        //       ],
        //     ),
        //   ),
        // ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.15,
          width: MediaQuery.of(context).size.width * 1.0,
          child: Padding(
            padding: EdgeInsets.only(left: 25.0),
            child: Row(
              children: <Widget>[
                SizedBox(
                  height: 120.0,
                  width: 120.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(90.0),
                    child:
                    Icon(Icons.account_circle,
                    size:60
                    )
                    //  Image.asset("assets/images/userimg.png")
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.15,
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(top: 5.0),
                        child: Text(
                          _currentUser.fname.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                        ),
                      ),
                      Divider(
                        thickness: 4.0,
                        endIndent: 4.0,
                        color: Colors.redAccent,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15.0),
                        child: Text(
                          // "jp@mail.id",
                        // global.EmailId,
                          _currentUser.email.toString(),
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              fontSize: 25.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        // Divider(
        //   thickness: 3.0,
        // ),
        Text(""),
        SizedBox(
            // height: MediaQuery.of(context).size.height * 0.2,
            // width: MediaQuery.of(context).size.width * 0.98,
            child: Padding(
              padding: EdgeInsets.only(left: 35.0, right: 35.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          'Mobile Number',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                        ),
                         Padding(
              padding: EdgeInsets.all(10.0),),
                        Text(
                          'Class',
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                        ),
                        // Text(
                        //   'DoDo Coins',
                        //   textDirection: TextDirection.ltr,
                        //   style: TextStyle(
                        //       fontSize: 20.0,
                        //       fontFamily: 'Montserrat',
                        //       fontWeight: FontWeight.w500),
                        // ),
                      ]),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          _currentUser.phone.toString(),
                          // global.MobileNumber.text,
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
                        ),
                        Padding(
              padding: EdgeInsets.all(10.0),),
                        Text(
                          // global.ReferralCode,
                          _currentUser.grade.toString(),
                          textDirection: TextDirection.ltr,
                          style: TextStyle(
                              fontSize: 20.0,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w400),
                        ),
                        // Row(
                        //   children: <Widget>[
                        //     SizedBox(
                        //         height: 25.0,
                        //         width: 25.0,
                        //         child: Image.asset('images/account_dodo.png')),
                        //     Padding(
                        //       padding: EdgeInsets.only(left: 30.0),
                        //       child: Text(
                        //         // global.coins,
                        //         textDirection: TextDirection.ltr,
                        //         style: TextStyle(
                        //             fontSize: 20.0,
                        //             fontFamily: 'Montserrat',
                        //             fontWeight: FontWeight.w400),
                        //       ),
                        //     ),
                        //   ],
                        // )
                      ])
                ],
              ),
            )),
        Divider(
          thickness: 3.0,
        ),
        SizedBox(
          //  height: MediaQuery.of(context).size.height * 0.2,
          // width: MediaQuery.of(context).size.width * 0.98,
          child:Column(
            children:<Widget>[
                         ListTile( 
                             title: new Text('About Us'),
                             leading: new Icon(Icons.chat_bubble_outline),
                             onTap: () {
                              Navigator.pushNamed(context,"/about");
                             },
                           ),
                            ListTile( 
                             title: new Text('Contact Us'),
                             leading: new Icon(Icons.contact_phone),
                             onTap: () {
                              Navigator.pushNamed(context,"/contact");
                             },
                           ),
                            ListTile( 
                             title: new Text('Pricing'),
                             leading: new Icon(Icons.account_balance_wallet),
                             onTap: () {
                              Navigator.pushNamed(context,"/pricing");
                             },
                           ),
                            ListTile( 
                             title: new Text('Privacy Policy'),
                             leading: new Icon(Icons.change_history),
                             onTap: () {
                              Navigator.pushNamed(context,"/privacy");
                             },
                           ),
                            ListTile( 
                             title: new Text('Terms & Conditions'),
                             leading: new Icon(Icons.mode_comment),
                             onTap: () {
                              Navigator.pushNamed(context,"/termsandconditions");
                             },
                           ),
                            ListTile( 
                             title: new Text('Cancellation/Refund Policy'),
                             leading: new Icon(Icons.chat_bubble_outline),
                             onTap: () {
                              
                              Navigator.pushNamed(context,"/refund");
                             },
                           ),
                             ListTile( 
                             title: new Text('Logout'),
                             leading: new Icon(Icons.settings_phone),
                             onTap: () {
                              showAlertDialog(context);
                             },
                           ),
            ]
          )
        ),
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
                      
//                     // Text(
//                     //   'Share and refer',
//                     //   textDirection: TextDirection.ltr,
//                     //   style: TextStyle(fontSize: 20.0),
//                     // ),
//                     // Text(
//                     //   'Contact Us',
//                     //   textDirection: TextDirection.ltr,
//                     //   style: TextStyle(fontSize: 20.0),
//                     // ),
//                     //  Text(
//                     //   'Sign out',
//                     //   textDirection: TextDirection.ltr,
//                     //   style: TextStyle(fontSize: 20.0),
//                     // ),GestureDetector(
// //               onTap: () {
// //                 showAlertDialog(context);
               
// //               },
// //               child: ListTile(
// //                 title: Text("Logout"),
// //               ),
// //             ),
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
      ],
    // )
    )
    )
    );
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
    onPressed: () { signOutGoogle();
                Navigator.of(context)
                    .pushNamedAndRemoveUntil('/Login', (_) => false);},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Logout"),
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
