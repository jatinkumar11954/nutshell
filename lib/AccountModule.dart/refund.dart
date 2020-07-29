import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:nutshell/bottomNav.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/services.dart' show rootBundle;

class Refund extends StatefulWidget {
  @override
  _RefundState createState() => _RefundState();
}

class _RefundState extends State<Refund> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return WillPopScope(
      onWillPop: () {
        Navigator.pushNamed(context, '/help');
      },
      child: Scaffold(
        // bottomNavigationBar: bottomBar(context, 2),
        appBar: AppBar(
          title: Text(
            "Refund/Cancellation Policy",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.orange[300],
          leading: new IconButton(
            icon: Icon(
              Icons.arrow_back,
              size: 30.0,
              color: Colors.black,
            ),
            tooltip: 'back',
            onPressed: () {
              Navigator.pushNamed(context, "/help");
            },
          ),
        ),
        body: WillPopScope(
          onWillPop: () {
            Navigator.pushNamed(context, '/help');
          },
          child: ListView(
            children: <Widget>[
              _buildRefund(),
              // Text("\n\n\n No Refunds till now",style: TextStyle(fontSize:SizeConfig.blockSizeVertical * 2.5,color: Colors.green),),
            ],
          ),
        ),
      ),
    );
  }

  // TODO: refactor the code
  _buildRefund() {
    print("called me");
    return Container(
      width: MediaQuery.of(context).size.width * 0.95,
      height: MediaQuery.of(context).size.height * 1,
      // width: 100,
      child: FutureBuilder<Directory>(
        future: getApplicationDocumentsDirectory(),
        builder: (BuildContext context, AsyncSnapshot<Directory> snapshot) {
          if (snapshot.hasData) {
            return Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                    border: Border.all(
                  color: Colors.green,
                )),
                child: Container(
                  child: FutureBuilder<String>(
                      future: rootBundle.loadString('assets/refund.html'),
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
                          return Center(child: CircularProgressIndicator());
                        }
                      }),
                ));
          }
          return IgnorePointer();
        },
      ),
    );
  }
}
