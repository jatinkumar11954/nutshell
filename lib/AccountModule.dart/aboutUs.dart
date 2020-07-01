import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nutshell/bottomNav.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_svg/flutter_svg.dart';

class AboutUs extends StatelessWidget {

 

  // VersionCheckBloc versionCheckBloc;

  @override
  Widget build(BuildContext context) {
    // versionCheckBloc = versionCheckBloc ?? VersionCheckBlocProvider.of(context);

    return Scaffold(
        bottomNavigationBar: bottomBar(context, 2),
        appBar: AppBar(
          title: Text("About US",style: TextStyle(color: Colors.black),),
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
            Text("Will be updated"),
          //   SizedBox(
          //     height: MediaQuery.of(context).size.height/2,
          //     width: MediaQuery.of(context).size.width,
          //     child:  SvgPicture.asset("assets/images/AboutUs.svg",    
          // ),
          //   ),
           
            // SvgPicture.asset("assets/images/INTRO1.svg"),
            // _buildBody(context),
            // Text("\n\n\n No TermsAndConditionss till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
          ],
        ),
        ),
     
    );
  }

  

}


