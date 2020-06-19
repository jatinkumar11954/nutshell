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
import 'package:nutshell/bottomNav.dart';
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
    // print("jp"+_currentUser.photoUrl.toString());
    return WillPopScope(
    onWillPop: (){
      Navigator.pushNamed(context,"/paperback");
    },
    child:Scaffold(
      bottomNavigationBar: bottomBar(context, 2),
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
        // title: new Text("Account Details",style: TextStyle(color:Colors.black,fontSize: 30.0),),
        backgroundColor: Colors.orange[2000],
        elevation: 5.0,

        
        // leading: new IconButton(
          
        //   icon: Icon(
        //                 Icons.arrow_back,
        //                 size: 30.0,
        //                 color: Colors.black,
        //               ),
        //               tooltip: 'Back',
        //               onPressed: () {
        //                 Navigator.pushNamed(context,"/paperback");
                    
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
        Padding(
          padding: const EdgeInsets.only(top:8.0,bottom: 8),
          child: ListTile(
                      leading: _currentUser.photoUrl.toString()=="null"?
                      // Text("No image")
                      // Image.network("https://nofrdz.com/images/l.png")
                      Icon(Icons.account_circle,
                      size:80
                      )
                      :CircleAvatar(
                        radius: 40.0,
                        backgroundImage:
                            NetworkImage(_currentUser.photoUrl.toString()),
                        backgroundColor: Colors.transparent,
                      ),
                      title: Padding(
                        padding: const EdgeInsets.only(top:18.0),
                        child: Text(_currentUser.fname.toString()+" "+_currentUser.lname.toString(),
                                // textAlign: TextAlign.end,
                                style: TextStyle(
                                  color: Colors.black,
                                    fontSize: 25.0,
                                    fontFamily: 'Montserrat',
                                    fontWeight: FontWeight.w500),),
                      ),
                      subtitle: Text(
                          _currentUser.group.toString() ,
                            style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Montserrat',
                                fontWeight: FontWeight.w500),),
                      trailing: Wrap()),
        ),
               Divider(
                 height: 45,
          thickness: 2.0,
          color: Colors.orange,
        ),
        Container(
        padding:new EdgeInsets.all(5.0),),
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
                             leading: new Icon(Icons.call),
                             onTap: () {
                              Navigator.pushNamed(context,"/contact");
                             },
                           ),
                            
                            ListTile( 
                             title: new Text('Help'),
                             leading: new Icon(Icons.assignment),
                             subtitle: Text("Privacy, Refund, TnC"),
                             onTap: () {
                              Navigator.pushNamed(context,"/help");
                             },
                           ),
                           
                             ListTile( 
                             title: new Text('Logout',
                             style: TextStyle(fontSize: 20.0
                              // color:Colors.deepOrange
                              ),
                             ),
                             leading: new Icon(Icons.settings_power,
                            //  color: Colors.deepOrange,
                             ),
                             onTap: () {
                              showAlertDialog(context);
                             },
                           ),
                              // RaisedButton(
                              //   // elevation: 50.0,
                              //   child: Text('Logout',style: TextStyle(fontSize: 20.0),),
                              //   textColor: Colors.white,
                              //   color: Colors.red,
                              //   onPressed: () => {showAlertDialog(context)},
                              // )
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
    title: Text("Logout",),
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



