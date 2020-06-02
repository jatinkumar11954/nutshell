import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ContactUs extends StatefulWidget
{
  @override
  _ContactUsState createState() => _ContactUsState();
}

class _ContactUsState extends State<ContactUs> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contact Us",style: TextStyle(color: Colors.black),),
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
        body:WillPopScope(
          onWillPop: (){
            Navigator.pushNamed(context, '/account');
          },
        child:Column(
          children: <Widget>[

            // Text("\n\n\n No ContactUss till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
          ],
        ),
        ),
      )
    );
  }
}