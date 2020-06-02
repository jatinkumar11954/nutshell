import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class TermsAndConditions extends StatefulWidget
{
  @override
  _TermsAndConditionsState createState() => _TermsAndConditionsState();
}

class _TermsAndConditionsState extends State<TermsAndConditions> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Terms and Conditions",style: TextStyle(color: Colors.black),),
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

            // Text("\n\n\n No TermsAndConditionss till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
          ],
        ),
        ),
      )
    );
  }
}