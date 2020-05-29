import 'package:flutter/material.dart';
import 'package:nutshell/google.dart';

class Account extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: ListView(
          children: [
            ListTile(
              title: Text("Edit Profile"),
            ),
            ListTile(
              title: Text("Manage Subscriptions"),
            ),
            ListTile(
              title: Text("About Us"),
            ),
            ListTile(
              title: Text("Contact Us"),
            ),
            GestureDetector(
              onTap: () {
                showAlertDialog(context);
               
              },
              child: ListTile(
                title: Text("Logout"),
              ),
            ),
          ],
        ));
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
