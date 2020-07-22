import 'package:flutter/material.dart';
import 'package:nutshell/orderConfirmation.dart';
import 'package:nutshell/users.dart';
import './paperback.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'database.dart';
import 'global.dart' as global;
// import 'AccountModule.dart/about.dart';
import 'AccountModule.dart/contactUs.dart';
import 'AccountModule.dart/pricing.dart';
import 'AccountModule.dart/privacy.dart';
import 'AccountModule.dart/refund.dart';
import 'AccountModule.dart/termsandconditions.dart';
import 'editprofilescreen.dart';
import 'account.dart';
import 'AccountModule.dart/aboutUs.dart';
import 'orderConfirmation.dart';
import 'AccountModule.dart/help.dart';

String phone;
String email;

// class Details extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       theme: ThemeData(primarySwatch: Colors.blue),
//       debugShowCheckedModeBanner: false,
//       home: Scaffold(
//         body: NameScreen(),
//       ),
//       routes: <String, WidgetBuilder>{
//         // '/landingpage': (BuildContext context) => new (),
//         '/name': (BuildContext context) => new NameScreen(),
//         '/email': (BuildContext context) => new Email(),
//         '/birth': (BuildContext context) => new BirthDay(),
//         '/instution': (BuildContext context) => new Instution(),
//         '/pincode': (BuildContext context) => new PinCode(),
//         '/paperback': (BuildContext context) => Paperbacks(),
//         '/group': (BuildContext context) => GroupScreen(),
//         '/account': (BuildContext context) => Account(),
//         // '/about': (BuildContext context) => About(),
//         '/help': (BuildContext context) => Help(),
//         '/contact': (BuildContext context) => ContactUs(),
//         '/pricing': (BuildContext context) => Pricing(),
//         '/privacy': (BuildContext context) => Privacy(),
//         '/refund': (BuildContext context) => Refund(),
//         '/termsandconditions': (BuildContext context) => TermsAndConditions(),
//         '/editprofile': (BuildContext context) => EditProfileScreen(),
//         '/aboutUs': (BuildContext context) => AboutUs(),
//       },
//     );
//   }
// }

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool btn_enable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
            onWillPop: () {
              print("going back from name");
              // callSnackBar("Exit");
              // Navigator.pushNamed(context, "/landingpage");
              Details();
            },
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.all(15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      Text(
                        'My \nName is',
                        style: TextStyle(
                            fontSize: 75.0,
                            color: Colors.redAccent[700],
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.1,
                      ),
                      TextFormField(
                        autovalidate: true,
                        validator: (String txt) {
                          if (txt.length >= 3) {
                            Future.delayed(Duration.zero).then((_) {
                              setState(() {
                                btn_enable = true;
                                global.name = txt;
                              });
                            });
                          } else {
                            Future.delayed(Duration.zero).then((_) {
                              setState(() {
                                btn_enable = false;
                              });
                            });
                          }
                        },
                        decoration: InputDecoration(
                            hintText: 'Enter Your Name',
                            hintStyle: TextStyle(
                                fontSize: 30.0, fontWeight: FontWeight.w600)),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.95,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: RaisedButton(
                          color: Colors.redAccent[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          // padding: EdgeInsets.fromLTRB(180.0, 15.0, 190.0, 15.0),
                          onPressed: btn_enable == true
                              ? () {
                                  Navigator.of(context).pushNamed('/email');
                                }
                              : null,
                        ),
                      ),
                    ],
                  ),
                )
              ],
            )));
  }
}

class Email extends StatefulWidget {
  @override
  _EmailState createState() => _EmailState();
}

class _EmailState extends State<Email> {
  bool btn_enable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
            onWillPop: () {
              print("going back from name");
              // callSnackBar("Exit");
              // Navigator.pushNamed(context, "/landingpage");
              Details();
            },
            child: ListView(children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      global.isGLogin ? 'My \nPhone \nis' : 'My \nEmail \nis ',
                      style: TextStyle(
                          fontSize: 75.0,
                          color: Colors.redAccent[700],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    TextFormField(
                      // controller: validateEmail(),
                      autovalidate: true,
                      validator: (String txt) {
                        if (global.isGLogin) {
                          if (txt.length == 10)
                            Future.delayed(Duration.zero).then((_) {
                              setState(() {
                                btn_enable = true;
                                global.phone = txt;
                              });
                            });
                        } else if (txt.length >= 6) {
                          Future.delayed(Duration.zero).then((_) {
                            setState(() {
                              btn_enable = true;
                              global.emailOrNumVal = txt;
                            });
                          });
                        } else {
                          Future.delayed(Duration.zero).then((_) {
                            setState(() {
                              btn_enable = false;
                            });
                          });
                        }
                      },
                      keyboardType: global.isGLogin
                          ? TextInputType.number
                          : TextInputType.emailAddress,
                      decoration: InputDecoration(
                          hintText: global.isGLogin
                              ? 'Enter Your Phone'
                              : 'Enter Your Email',
                          hintStyle: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RaisedButton(
                          color: Colors.redAccent[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          // padding: EdgeInsets.fromLTRB(180.0, 15.0, 190.0, 15.0),
                          onPressed: btn_enable == true
                              ? () {
                                  Navigator.of(context).pushNamed('/birth');
                                }
                              : null),
                    ),
                  ],
                ),
              )
            ])));
  }
}

class BirthDay extends StatefulWidget {
  @override
  _BirthDayState createState() => _BirthDayState();
}

class _BirthDayState extends State<BirthDay> {
  bool btn_enable = false;
  String birthDateInString;
  DateTime birthDate;
  bool isDateSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
            onWillPop: () {
              print("going back from name");
              // callSnackBar("Exit");
              // Navigator.pushNamed(context, "/landingpage");
              Details();
            },
            child: ListView(children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      'My \nbirthday is',
                      style: TextStyle(
                          fontSize: 75.0,
                          color: Colors.redAccent[700],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: InkWell(
                        child: Row(
                          children: <Widget>[
                            Text(
                              birthDateInString == null
                                  ? 'DD/MM/YYYY     '
                                  : "   " + birthDateInString + "  ",
                              style: TextStyle(
                                  fontSize: 35.0, fontWeight: FontWeight.w600),
                            ),
                            Icon(
                              Icons.calendar_today,
                              color: Colors.red,
                              size: 35.0,
                            )
                          ],
                        ),
                        onTap: () async {
                          final datePick = await showDatePicker(
                              context: context,
                              initialDate: new DateTime(1999, 06, 25),
                              firstDate: new DateTime(1970),
                              lastDate: new DateTime(2013));
                          if (datePick != null && datePick != birthDate) {
                            setState(() {
                              birthDate = datePick;
                              isDateSelected = true;
                              birthDateInString =
                                  "${birthDate.month}/${birthDate.day}/${birthDate.year}"; // 08/14/2019
                              global.dob = birthDateInString;
                            });
                          }

                          setState(() {
                            btn_enable = true;
                          });
                        },
                      ),
                    ),
                    // SizedBox(
                    //   height: MediaQuery.of(context).size.height * 0.05,
                    // ),
                    // TextFormField(
                    //   autovalidate: true,
                    //   decoration: InputDecoration(
                    //       hintText: birthDateInString==null?'DD/MM/YYYY':birthDateInString,
                    //       hintStyle:
                    //           TextStyle(fontSize: 30.0, fontWeight: FontWeight.w600),
                    //       suffixIcon: IconButton(
                    //         color: Colors.red,
                    //         icon: Icon(Icons.calendar_today),
                    //         onPressed: () async{
                    //           print("clicked");
                    //           final datePick= await showDatePicker(
                    //             context: context,
                    //             initialDate: new DateTime(1999,06,25),
                    //             firstDate: new DateTime(1970),
                    //             lastDate: new DateTime(2013)
                    //         );
                    //         if(datePick!=null && datePick!=birthDate){
                    //           setState(() {
                    //                   birthDate=datePick;
                    //               isDateSelected=true;

                    //               // put it here
                    //               birthDateInString = "${birthDate.month}/${birthDate.day}/${birthDate.year}"; // 08/14/2019
                    //               global.dob=birthDateInString;
                    //             });
                    //           }

                    //         setState(() {
                    //           btn_enable = true;
                    //         });

                    //         },
                    //       )),
                    // ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RaisedButton(
                          color: Colors.redAccent[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          // padding: EdgeInsets.fromLTRB(180.0, 15.0, 190.0, 15.0),
                          onPressed: btn_enable == true
                              ? () {
                                  Navigator.of(context).pushNamed('/instution');
                                }
                              : null),
                    ),
                  ],
                ),
              )
            ])));
  }
}

class Instution extends StatefulWidget {
  @override
  _InstutionState createState() => _InstutionState();
}

class _InstutionState extends State<Instution> {
  bool btn_enable = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
            onWillPop: () {
              print("going back from name");
              // callSnackBar("Exit");
              // Navigator.pushNamed(context, "/landingpage");
              Details();
            },
            child: ListView(children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      'My \nInstitution is',
                      style: TextStyle(
                          fontSize: 75.0,
                          color: Colors.redAccent[700],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    TextFormField(
                      autovalidate: true,
                      validator: (String txt) {
                        if (txt.length >= 3) {
                          Future.delayed(Duration.zero).then((_) {
                            setState(() {
                              btn_enable = true;
                              global.ins = txt;
                            });
                          });
                        } else {
                          Future.delayed(Duration.zero).then((_) {
                            setState(() {
                              btn_enable = false;
                            });
                          });
                        }
                      },
                      // controller: cont,
                      decoration: InputDecoration(
                          hintText: 'Enter Your Institution',
                          hintStyle: TextStyle(
                              fontSize: 30.0, fontWeight: FontWeight.w600)),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RaisedButton(
                          color: Colors.redAccent[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          // padding: EdgeInsets.fromLTRB(180.0, 15.0, 190.0, 15.0),
                          onPressed: btn_enable == true
                              ? () {
                                  Navigator.of(context).pushNamed('/pincode');
                                }
                              : null),
                    ),
                  ],
                ),
              )
            ])));
  }
}

class PinCode extends StatefulWidget {
  @override
  _PinCodeState createState() => _PinCodeState();
}

class _PinCodeState extends State<PinCode> {
  String pinCode;
  bool _isLoading = false;
  bool btn_enable = false;

  Geolocator geolocator = Geolocator();

  Future<Position> _getLocation() async {
    var currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          // desiredAccuracy: LocationAccuracy.best
          );
    } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  @override
  Widget build(BuildContext context) {
    Position userLocation;

    void callMe(Position userLocation) async {
      print("called for pLacemark");
      List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(
          userLocation.latitude, userLocation.longitude);

      print(placemark[0].postalCode);
      setState(() {
        pinCode = placemark[0].postalCode;
        btn_enable = true;
        _isLoading = false;
      });
      // print(placemark[0].name+placemark[0].administrativeArea+placemark[0].name+placemark[0].administrativeArea);
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: WillPopScope(
            onWillPop: () {
              print("going back from name");
              // callSnackBar("Exit");
              Navigator.pushNamed(context, "/landingpage");
              // Details();
            },
            child: ListView(children: <Widget>[
              Container(
                padding: EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    Text(
                      'My \nPincode is',
                      style: TextStyle(
                          fontSize: 75.0,
                          color: Colors.redAccent[700],
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.1,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 1,
                      child: Row(
                        children: <Widget>[
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.4,
                            child: TextFormField(
                                autovalidate: true,
                                validator: (String txt) {
                                  if (txt.length >= 6) {
                                    Future.delayed(Duration.zero).then((_) {
                                      setState(() {
                                        btn_enable = true;
                                        global.pincode = txt;
                                      });
                                    });
                                  } else {
                                    Future.delayed(Duration.zero).then((_) {
                                      setState(() {
                                        btn_enable = false;
                                      });
                                    });
                                  }
                                },
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    hintText: pinCode == null ? pinCode : "",
                                    labelText: pinCode == null
                                        ? ' Enter Pincode'
                                        : pinCode),
                                // validator: validateCity,
                                onSaved: (String value) {
                                  pinCode = value;
                                }),
                          ),
                          InkWell(
                            child: _isLoading
                                ? CircularProgressIndicator()
                                : SizedBox(
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Row(
                                      children: <Widget>[
                                        Text(" Or Autolocate "),
                                        Icon(
                                          Icons.my_location,
                                          color: Colors.red,
                                          size: 40,
                                          //  my_location
                                        ),
                                      ],
                                    )),
                            onTap: () async {
                              setState(() {
                                _isLoading = true;
                              });
                              _getLocation().then((value) {
                                setState(() {
                                  // isLoading=true;
                                  // btn_enable = true;
                                  userLocation = value;
                                });
                                // await
                                callMe(userLocation);
                              });
                            },
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.95,
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: RaisedButton(
                          color: Colors.redAccent[700],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Text(
                            'Continue',
                            style: TextStyle(
                                fontSize: 40.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          // padding: EdgeInsets.fromLTRB(180.0, 15.0, 190.0, 15.0),
                          onPressed: btn_enable == true
                              ? () {
                                  print("clik");
                                  Navigator.pushNamed(context, "/group");
                                }
                              : null),
                    ),
                  ],
                ),
              )
            ])));
  }
}

class GroupScreen extends StatefulWidget {
  @override
  _GroupScreenState createState() => _GroupScreenState();
}

class _GroupScreenState extends State<GroupScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(
                left: 20.0, top: 10.0, bottom: 10.0, right: 10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * 0.08,
                // ),
                Text(
                  'Please select \na group',
                  style: TextStyle(
                      fontSize: 50.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent[700]),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      global.group = "A";
                      OurDatabase().createUser();
                      // Navigator.pushNamed(context, "/orderConfirm");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderConfirmation()));
                    },
                    child: SvgPicture.asset('assets/images/GroupB.svg'),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 3,
                  width: MediaQuery.of(context).size.width,
                  child: FlatButton(
                    splashColor: Colors.white,
                    onPressed: () {
                      global.group = "B";
                      OurDatabase().createUser();

                      // Navigator.pushNamed(context, "/orderConfirm");
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => OrderConfirmation()));
                    },
                    child: SvgPicture.asset('assets/images/GroupA.svg'),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
