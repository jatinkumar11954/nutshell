import 'package:flutter/material.dart';

import '../bottomNav.dart';

class Help extends StatefulWidget {
  @override
  _HelpState createState() => _HelpState();
}

class _HelpState extends State<Help> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        bottomNavigationBar: bottomBar(context, 2),
      appBar: AppBar(
          title: Text("Help",style: TextStyle(color: Colors.black),),
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
          )),
          body:   WillPopScope(
          onWillPop: (){
            Navigator.pushNamed(context, '/account');
          },
                      child: Padding(
              padding: const EdgeInsets.only(top
              :28.0,left: 5),
              child: Column(
                children:<Widget>[
                             ListTile( 
                                 title: new Text('Terms and COnditions'),
                                 leading: new Icon(Icons.assignment),
                                 onTap: () {
                                  Navigator.pushNamed(context,"/termsandconditions");
                                 },
                               ),
                             ListTile( 
                                 title: new Text('Privacy Policy'),
                                 leading: new Icon(Icons.description),
                                 onTap: () {
                                  Navigator.pushNamed(context,"/privacy");
                                 },
                               ),
                             
                                ListTile( 
                                 title: new Text('Cancellation/Refund Policy'),
                                 leading: new Icon(Icons.autorenew),
                                 onTap: () {
                                  
                                  Navigator.pushNamed(context,"/refund");
                                 },
                               ),
                              ]),
            ),
          )
    );
  }
}