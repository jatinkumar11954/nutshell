import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
// import 'package:url_launcher/url_launcher.dart';

class DummyScreen extends StatefulWidget{
  @override
  _DummyScreenState createState() => _DummyScreenState();
}

class _DummyScreenState extends State<DummyScreen> {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      debugShowCheckedModeBanner: false,
      home: new Scaffold(
        appBar: new AppBar(
          title: new Text("Razorpay Screen",style:TextStyle(color: Colors.black)),
          backgroundColor: Colors.orange[300],
        ),
        // bottomNavigationBar: bottomnavigation(context,1),
        // drawer: theDrawer(context),
        body:Center(
        child: Column(
          children: <Widget>[
             Padding(padding: EdgeInsets.all(30)),
          Text("Razorpay Coming soon!!!"),
             Padding(padding: EdgeInsets.all(40)),
          RaisedButton(
                        child: Text("Skip or HomeScreen"),
                        color: Colors.redAccent,
                        onPressed: () async
                        {    Navigator.pushNamed(context, "/paperback");
                        }
          ),
          ],
    ),
        ),
      ),
    
    );
}
}