import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;

class Privacy extends StatefulWidget
{
  @override
  _PrivacyState createState() => _PrivacyState();
}

class _PrivacyState extends State<Privacy> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Privacy Policy",style: TextStyle(color: Colors.black),),
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
        child:ListView(
          children: <Widget>[
            _buildPrivacy(),
            // Text("\n\n\n No Privacys till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
          ],
        ),
        ),
      )
    );
  }
  
  // TODO: refactor the code
  _buildPrivacy() {
    print("called me");
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height *1 ,
      // width: 100,
      child: FutureBuilder<Directory>(
        future: getApplicationDocumentsDirectory(),
        builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
          if (snapshot.hasData) {
            return Container(
              margin: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green,)
              ),
              child: Container(
                child: FutureBuilder<String>(
                  future: rootBundle.loadString('assets/privacy.html'),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return SingleChildScrollView(
                                              child: Html(
                          data: '''
                            ${snapshot.data}
                          ''',
                        ),
                      );
                    } else {
                      return IgnorePointer();
                    }
                  }
                ),
              )
            );
          }
          return IgnorePointer();
        },
      ),
    );
  }

}