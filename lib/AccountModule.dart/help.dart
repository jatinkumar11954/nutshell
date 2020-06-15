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
          )),
          body: Column(
            children:<Widget>[
                         ListTile( 
                             title: new Text('Terms and COnditions'),
                             leading: new Icon(Icons.assignment),
                             onTap: () {
                              Navigator.pushNamed(context,"/termsandconditions");
                             },
                           ),
                          //   ListTile( 
                          //    title: new Text('Contact Us'),
                          //    leading: new Icon(Icons.call),
                          //    onTap: () {
                          //     Navigator.pushNamed(context,"/contact");
                          //    },
                          //  ),
                          ])
    );
  }
}