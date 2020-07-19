import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutshell/bottomNav.dart';
import 'package:nutshell/database.dart';
import 'package:nutshell/users.dart';
import '../global.dart' as global;

class Pricing extends StatefulWidget {
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {
  Users _currentUser = Users();
  var today = global.timeCreated == null ? DateTime.now() : global.timeCreated;
  var expiryDate;
  Users get getCurrentUser => _currentUser;
  bool isLoading = false;
  var Plan = " ";
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
          print("in if " + _currentUser.subPlan + " jui");
          print(_currentUser.phone);
          setState(() {
            // _currentUser.subPlan==null?_currentUser.subPlan=global.subPlan:print("Yes, value is found");

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
    if (_currentUser.subPlan == 'f') {
      Plan = "Free";
      expiryDate = today.add(new Duration(days: 7));
    } else if (_currentUser.subPlan == 'b') {
      Plan = "Basic";

      expiryDate = today.add(new Duration(days: 60));
    } else if (_currentUser.subPlan == 's') {
      Plan = "Standard";

      expiryDate = today.add(new Duration(days: 183));
    } else if (_currentUser.subPlan == 'p') {
      Plan = "Premium";

      expiryDate = today.add(new Duration(days: 365));
    }
    // TODO: implement build
    return Scaffold(
      bottomNavigationBar: bottomBar(context, 2),
      appBar: AppBar(
        title: Text(
          "Pricing",
          style: TextStyle(color: Colors.black),
        ),
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
          ? Center(
              child: CircularProgressIndicator(),
            )
          : WillPopScope(
              onWillPop: () {
                Navigator.pushNamed(context, '/account');
              },
              child: Container(
                padding: EdgeInsets.only(left: 25.0, top: 25.0, right: 25.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Text(
                      "Your current \nplan",
                      style: TextStyle(
                          fontSize: 75.0,
                          color: Colors.redAccent[700],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Your Subsciption type is :",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          Plan,
                          style: TextStyle(
                              fontSize: 25.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Text(
                          "Valid till :",
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                        Text(
                          expiryDate.toString(),
                          style: TextStyle(
                              fontSize: 20.0, fontWeight: FontWeight.w700),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Divider(
                      color: Colors.black,
                      thickness: 3.0,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                      width: MediaQuery.of(context).size.width * 0.90,
                      child: RaisedButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0)),
                        color: Colors.redAccent[700],
                        onPressed: () {
                          Navigator.pushNamed(context, "/subs");
                        },
                        child: Text(
                          'Extend plan',
                          style: TextStyle(
                              fontSize: 35.0,
                              color: Colors.white,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    )
                    // Text("Will be added")
                    // _currentUser.subPlan.toString() == 'f'
                    //     ? Text(
                    //         "Price: ₹0\nPlan:FREE includes:\nDuration: 7 days\n No. of paperbacks:2\nIssues:2")
                    //     : _currentUser.subPlan.toString() == 'b'
                    //         ? Text(
                    //             "Price: ₹69\nPlan:Basic includes:\nDuration: 2 months\n No. of paperbacks:1\nIssues:1")
                    //         : _currentUser.subPlan.toString() == 's'
                    //             ? Text(
                    //                 "Price: ₹56 per issue\nPlan:Standard includes:\nDuration: 6 months\n No. of paperbacks:3\n")
                    //             : _currentUser.subPlan.toString() == 'p'
                    //                 ? Text(
                    //                     "Price: ₹50 per issue\nPlan:Standard includes:\nDuration: 12 months\n No. of paperbacks:6\n")
                    //                 : Text("Error"),
                  ],
                ),

                // Text("\n\n\n No Pricings till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
              ),
            ),
    );
  }
}
