import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:nutshell/bottomNav.dart';
import 'package:nutshell/database.dart';
import 'package:nutshell/users.dart';
import '../global.dart' as global;

class Pricing extends StatefulWidget
{
  @override
  _PricingState createState() => _PricingState();
}

class _PricingState extends State<Pricing> {

    Users _currentUser = Users();

  Users get getCurrentUser => _currentUser;
  bool isLoading=false;
  var Plan=" ";
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
          print("in if "+_currentUser.subPlan+" jui");
          print(_currentUser.phone);
            setState(() {
              // _currentUser.subPlan==null?_currentUser.subPlan=global.subPlan:print("Yes, value is found");
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
    if(_currentUser.subPlan=='f')
    {
      Plan="Free";

    }
    else if(_currentUser.subPlan=='b')
    {
      Plan="Basic";

    }
    else if(_currentUser.subPlan=='s')
    {
      Plan="Standard";

    }
    else if(_currentUser.subPlan=='p')
    {
      Plan="Premium";

    }
    // TODO: implement build
    return  Scaffold(
        bottomNavigationBar: bottomBar(context, 2),
        appBar: AppBar(
          title: Text("Pricing",style: TextStyle(color: Colors.black),),
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
        body:isLoading?
      Center(child: CircularProgressIndicator(),):
        WillPopScope(
          onWillPop: (){
            Navigator.pushNamed(context, '/account');
          },
        child:Column(
          children: <Widget>[

              SizedBox(
                // height: 200,
                // width: 200,
                child:Column(children: <Widget>[
                  Text("   \n\n         Your Subsciption type is :",style: TextStyle(fontSize:20.0),),
                   Text(Plan,style: TextStyle(fontSize:25.0),),
                  // Text("Will be added")
                _currentUser.subPlan.toString()=='f'?Text("Price: ₹0\nPlan:FREE includes:\nDuration: 7 days\n No. of paperbacks:2\nIssues:2"):_currentUser.subPlan.toString()=='b'? Text("Price: ₹69\nPlan:Basic includes:\nDuration: 2 months\n No. of paperbacks:1\nIssues:1"):_currentUser.subPlan.toString()=='s'?Text("Price: ₹56 per issue\nPlan:Standard includes:\nDuration: 6 months\n No. of paperbacks:3\n"):
         _currentUser.subPlan.toString()=='p'? Text("Price: ₹50 per issue\nPlan:Standard includes:\nDuration: 12 months\n No. of paperbacks:6\n"):Text("Error"),
         
                ],)
              ),
              
            // Text("\n\n\n No Pricings till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
          ],
        ),
        ),
    
    );
  }
}