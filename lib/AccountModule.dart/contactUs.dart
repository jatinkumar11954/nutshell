// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';

// class ContactUs extends StatefulWidget
// {
//   @override
//   _ContactUsState createState() => _ContactUsState();
// }

// class _ContactUsState extends State<ContactUs> {
//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text("Contact Us",style: TextStyle(color: Colors.black),),
//           backgroundColor:Colors.orange[300],
//           leading: new IconButton(
//           icon: Icon(
//                         Icons.arrow_back,
//                         size: 30.0,
//                         color: Colors.black,
//                       ),
//                       tooltip: 'back',
//                       onPressed: () {
//                         Navigator.pushNamed(context,"/account");
                    
//           },
//         ),
//         ),
//         body:WillPopScope(
//           onWillPop: (){
//             Navigator.pushNamed(context, '/account');
//           },
//         child:Column(
//           children: <Widget>[
//             Text("dsjh"),
//             // Text("\n\n\n No ContactUss till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
//           ],
//         ),
//         ),
//       )
//     );
//   }
// }






import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;

class ContactUs extends StatelessWidget {

 

  // VersionCheckBloc versionCheckBloc;

  @override
  Widget build(BuildContext context) {
    // versionCheckBloc = versionCheckBloc ?? VersionCheckBlocProvider.of(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text("Contact US",style: TextStyle(color: Colors.black),),
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
            _buildBody(context),
            // Text("\n\n\n No TermsAndConditionss till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
          ],
        ),
        ),
      )
    );
  }

  _buildBody(context) {
    return SizedBox(
      // width: MediaQuery.of(context).size.width * 0.8,
      // height: MediaQuery.of(context).size.width * 0.7,
      // margin: EdgeInsets.only(left: 20, right: 20, top: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: Image.asset('assets/images/logo.png', fit: BoxFit.fitHeight, width: MediaQuery.of(context).size.width * 0.95, height: 100),
          ),
          // Text("Nutshell",
          //   style: TextStyle(
          //     color: Colors.green,
          //     fontWeight: FontWeight.w500,
          //     fontSize: 20
          //   ),
          // ),
          Padding(padding:EdgeInsets.all(10.0)),
          Text("If you have any questions or feedback, please reach out to us:",
            
          ),
          Text("\n"),
          Container(
            // padding: EdgeInsets.fromLTRB(0, 15, 0, 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: MediaQuery.of(context).size.width * 0.3,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    child: Column(
                    //   crossAxisAlignment: CrossAxisAlignment.start,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Text("ADDRESS", style: TextStyle(color: Colors.green, fontSize: 12),),
                      SizedBox(height: 75,
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: Text(" \nQuizzora & Co., 2nd Floor, Basera Apartment, Hill Cart, Road, 13/6 B.M. Saran, Mahananda Para, Near Bata Lane,Siliguri - 734001", style: TextStyle(color: Colors.black, fontSize: 16),)
                      ),
                      // Text(" ", style: TextStyle(color: Colors.black, fontSize: 16),),
                      // Text(" ", style: TextStyle(color: Colors.black, fontSize: 16),),
                      // Text(" Siliguri - 734001", style: TextStyle(color: Colors.green, fontSize: 16),)
                    ],
                  ),
                ),
                ),
                InkWell(
                  onTap: () {
                    _launchMaps("26.713500", "88.424280");
                  },
                  child: Row(children: <Widget>[
                    Icon(Icons.directions, color: Colors.green,),
                    Text("      ")
                  ],)
                  // 
                )
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("     PHONE", style: TextStyle(color: Colors.green,fontSize: 12)),
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("    8617587964", style: TextStyle(color: Colors.black, fontSize: 16)),
                InkWell(
                  onTap: () {
                    _LaunchPhone("8617587964");
                  },
                  child: 
                  Row(children: <Widget>[Icon(Icons.phone, color: Colors.green,),
                
                    Text("      ")
                  ],
                  )
                  )
              ],
            ),
          ),
           Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Text("    9647837544", style: TextStyle(color: Colors.black, fontSize: 16)),
                InkWell(
                  onTap: () {
                    _LaunchPhone("9647837544");
                  },
                  child: Row(children: <Widget>[Icon(Icons.phone, color: Colors.green,),
                
                    Text("      ")
                  ],
                  )
                )
              ],
            ),
          ),
          Divider(),
          Container(
            margin: EdgeInsets.symmetric(vertical: 5),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("    EMAIL", style: TextStyle(color: Colors.green, fontSize: 12)),
              ],
            )
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("    info@mynutshell.in", style: TextStyle(color: Colors.black, fontSize: 16)),
              InkWell(
                onTap: () {
                  _launchEmail("info@mynutshell.in");
                },
                child: 
                Row(children: <Widget>[Icon(Icons.email, color: Colors.green,),
                    Text("      ")
                  ],
                  )              )
            ]
          )
        ],
      ),
    );
  }

//  file != null ? Uri.file(snapshot.data.path+"/termsandconditions.html").toString() :
  _LaunchPhone(String number) async {
    String mobileUrl = "tel:${number}";
    if (await canLaunch(mobileUrl)) {
      await launch(mobileUrl);
    } else {
      // logger.info("Can't open phone");

    }
  }

  _launchEmail(String email) async{ 
    String mailUrl = "mailto:${email}";
    if (await canLaunch(mailUrl)) {
      await launch(mailUrl);
    } else {
      // logger.info("Can't open phone");
    }
  }

  _launchMaps(String lat, String lon) async {
    var url = 'https://goo.gl/maps/gYcPEnUbqeF8QDac7';
    if (Platform.isIOS) {
      // iOS
      url = 'https://goo.gl/maps/gYcPEnUbqeF8QDac7';
    }
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

}