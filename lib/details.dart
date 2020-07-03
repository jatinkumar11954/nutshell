import 'package:flutter/material.dart';
import 'package:nutshell/orderConfirmation.dart';
import 'package:nutshell/users.dart';
import './paperback.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'database.dart';
import 'global.dart' as global;
import 'AccountModule.dart/about.dart';
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

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.blue),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: NameScreen(),
      ),
      routes: <String, WidgetBuilder>{
        // '/landingpage': (BuildContext context) => new (),
        '/name': (BuildContext context) => new NameScreen(),
        '/email': (BuildContext context) => new Email(),
        '/birth': (BuildContext context) => new BirthDay(),
        '/instution': (BuildContext context) => new Instution(),
        '/pincode': (BuildContext context) => new PinCode(),
        '/paperback': (BuildContext context) => Paperbacks(),
        '/group': (BuildContext context) => GroupScreen(),
        '/account': (BuildContext context) => Account(),
        '/about': (BuildContext context) => About(),
        '/help': (BuildContext context) => Help(),
        '/contact': (BuildContext context) => ContactUs(),
        '/pricing': (BuildContext context) => Pricing(),
        '/privacy': (BuildContext context) => Privacy(),
        '/refund': (BuildContext context) => Refund(),
        '/termsandconditions': (BuildContext context) => TermsAndConditions(),
        '/editprofile': (BuildContext context) => EditProfileScreen(),
        '/aboutUs': (BuildContext context) => AboutUs(),
      },
    );
  }
}

class NameScreen extends StatefulWidget {
  @override
  _NameScreenState createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
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
                                // autovalidate: true,
                                validator: (String txt) {
                                  if (txt.length >= 8) {
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

// import 'package:flutter/material.dart';
// import 'package:nutshell/orderConfirmation.dart';
// import 'package:nutshell/users.dart';

// import 'package:geolocator/geolocator.dart';
// import 'database.dart';
// import 'subscription.dart';
// import 'global.dart' as global;

// String phone;
// String email;

// TextEditingController _fnamecontroller = TextEditingController();
// TextEditingController _lnamecontroller = TextEditingController();
// TextEditingController _schoolcontroller = TextEditingController();
// TextEditingController _classcontroller = TextEditingController();
// TextEditingController _emailcontroller = TextEditingController();
// TextEditingController _phonecontroller = TextEditingController();
// TextEditingController _citycontroller = TextEditingController();
// TextEditingController _pinCodecontroller = TextEditingController();

// class Details extends StatefulWidget {
//   @override
//   _DetailsState createState() => _DetailsState();
// }

// class _DetailsState extends State<Details> {
//   bool isLoading=false;
//   bool submitLoading=false;
//   Users _currentUser = Users();
//   Users get getCurrentUser => _currentUser;
//     final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   _DetailsState({
//     Key key,
//   });

//   bool _validate = false;
//   @override
//   void initState() {
//     super.initState();
//   }

//   final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

//   final text = TextEditingController();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: Colors.white,
//         elevation: 0.0,
//         // iconTheme: IconThemeData(
//         //   color: Colors.black,
//         //   size: 80.0,
//         // ),
//       ),
//       body: Center(
//         child: new Form(
//           key: _formKey,
//           autovalidate: _validate,
//           child: FormUI(),
//         ),
//       ),
//     );
//   }

// var _dropforms= [
//    'Select Group','Group-A','Group-B'
//   ];
//   var _dropformSelected="Select Group";

//   String pinCode;
//   String birthDateInString;
//   DateTime birthDate;
//   bool isDateSelected= false;

//   Geolocator geolocator = Geolocator();

//    Future<Position> _getLocation() async {
//     var currentLocation;
//     try {
//         currentLocation= await geolocator.getCurrentPosition(
//           // desiredAccuracy: LocationAccuracy.best

//         );
//       // currentLocation = await geolocator.getCurrentPosition(
//       //     // desiredAccuracy: LocationAccuracy.best
//       //     );

//        } catch (e) {
//       currentLocation = null;
//     }
//     return currentLocation;
//   }

//   Widget FormUI() {

//   Position userLocation;

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     _getLocation().then((position) {
//       userLocation = position;

//     });
//   }

//   void callMe(Position userLocation)async{
//     print("called for pLacemark");
//     List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(userLocation.latitude,userLocation.longitude);

//     print(placemark[0].postalCode);
//     setState(() {

//     pinCode= placemark[0].postalCode;
//     _currentUser.pinCode=placemark[0].postalCode;
//     isLoading=false;
//     });
//     // print(placemark[0].name+placemark[0].administrativeArea+placemark[0].name+placemark[0].administrativeArea);
//   }

//     _currentUser.sID = sID;
//      bool selected = false;
//     return ListView(
//        children: <Widget>[

//      Column(
//       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: <Widget>[
//         SizedBox(
//           width: MediaQuery.of(context).size.width - 100,
//           child: Text(
//             "Enter your Details",
//             style: TextStyle(
//               color: Colors.black,
//               fontSize: 25,
//               fontWeight: FontWeight.bold,
//             ),
//             textAlign: TextAlign.left,
//           ),
//         ),
//         // Padding(padding: EdgeInsets.all(20)),
//         Row(
//           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: <Widget>[
//             SizedBox(
//               width: 140,
//               child: TextFormField(
//                   controller: _fnamecontroller,

//                   keyboardType: TextInputType.text,
//                   decoration: InputDecoration(labelText: 'Enter First Name'),
//                   validator: validateName,
//                   onSaved: (String value) {
//                     _currentUser.fname = value;
//                   }),
//             ),
//             SizedBox(
//               width: 140,
//               child: TextFormField(
//                   controller: _lnamecontroller,

//                   keyboardType: TextInputType.text,
//                   decoration: InputDecoration(labelText: 'Enter Last Name'),
//                   validator: validateName,
//                   onSaved: (String value) {
//                     _currentUser.lname = value;
//                   }),
//             ),
//           ],
//         ),
//         Padding(padding: EdgeInsets.all(10)),
//         SizedBox(
//           width: 320,
//           child: TextFormField(
//               controller: _schoolcontroller,

//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(labelText: 'Enter School Name'),
//               validator: validateSchool,
//               onSaved: (String value) {
//                 _currentUser.school = value;
//               }),
//         ),
//         Padding(padding: EdgeInsets.all(10)),
//        SizedBox(
//           width: 320,
//        child: Row(
//           children: <Widget>[
//           Text(birthDateInString==null?"Please add Your DOB ":"DOB is "+birthDateInString+"  ",style: TextStyle(color: Colors.black,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,),),
//           GestureDetector(
//                 child: new Icon(Icons.calendar_today,
//                 size: 50.0,
//                 ),
//                 onTap: ()async{
//                   final datePick= await showDatePicker(
//                       context: context,
//                       initialDate: new DateTime(1999,06,25),
//                       firstDate: new DateTime(1970),
//                       lastDate: new DateTime(2013)
//                   );
//                   if(datePick!=null && datePick!=birthDate){
//                     setState(() {
//                             birthDate=datePick;
//                         isDateSelected=true;

//                         // put it here
//                         birthDateInString = "${birthDate.month}/${birthDate.day}/${birthDate.year}"; // 08/14/2019
//                         global.dob=birthDateInString;
//                       });
//                     }
//                   }
//               ),
//           ],
//         ),
//        ),
//         // Padding(padding: EdgeInsets.all(10)),
//         SizedBox(
//           width: 320,
//           child: TextFormField(
//               controller: _classcontroller,

//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(labelText: 'Enter Class'),
//               validator: validateClass,
//               onSaved: (String value) {
//                 _currentUser.grade = value;
//               }),
//         ),
//         Padding(padding: EdgeInsets.all(10)),
//         SizedBox(
//           width: 320,
//           child: TextFormField(
//               controller: _emailcontroller,

//               keyboardType: TextInputType.emailAddress,
//               decoration: InputDecoration(labelText: 'Enter Email Address'),
//               validator: validateEmail,
//               onSaved: (String value) {
//                 _currentUser.email = value;
//                 email = value;
//               }),
//         ),
//         Padding(padding: EdgeInsets.all(10)),
//         SizedBox(
//           width: 320,
//           child: TextFormField(
//               controller: _citycontroller,

//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(labelText: 'Enter City'),
//               validator: validateCity,
//               onSaved: (String value) {
//                 _currentUser.city = value;
//               }),
//         ),
//         Padding(padding: EdgeInsets.all(10)),

//         SizedBox(
//            width: 320,
//            child:Row(
//              children: <Widget>[
//               SizedBox(
//           width: MediaQuery.of(context).size.width/3,
//           child: TextFormField(
//               controller: _pinCodecontroller,

//               keyboardType: TextInputType.text,
//               decoration: InputDecoration(
//                 hintText: _currentUser.pinCode==null?pinCode:"",
//                 labelText: pinCode==null?'Enter Pincode':pinCode),
//               // validator: validateCity,
//               onSaved: (String value) {
//                 _currentUser.pinCode = value;
//               }),
//         ),

//               InkWell(
//               child: isLoading?CircularProgressIndicator():
//               SizedBox(
//           width: MediaQuery.of(context).size.width/3,
//               child:Row(
//                   children: <Widget>[
//               Text(" Or Tap here:  "),
//               Icon(
//                  Icons.my_location,
//                  color: Colors.blueGrey,
//                  size: 40,
//                 //  my_location
//                ),
//                   ],
//               )
//               ),
//                onTap: ()async{
//                  setState(() {
//                       isLoading=true;
//                       });
//                  _getLocation().then((value) {
//                     setState(() {
//                       // isLoading=true;
//                       userLocation = value;
//                     });
//                     // await
//                     callMe(userLocation);
//                   });
//                },
//               )
//              ],
//            ),

//         ),

//         Padding(padding: EdgeInsets.all(10)),
//         SizedBox(
//           width: 320,
//           child: TextFormField(
//               controller: _phonecontroller,

//               keyboardType: TextInputType.number,
//               decoration: InputDecoration(
//                   labelText: 'Enter Phone Number', prefix: Text("+91")),
//               validator: validatePhone,
//               onSaved: (String value) {
//                 _currentUser.phone = value;
//                 phone = value;
//               }),
//         ),
//         Padding(padding: EdgeInsets.all(10)),
//         SizedBox(
//           width: 320,
//           child: Text("Select Group\n1.Group A Suitable for students of ages 9-12\n2.Suitable for students of ages 13-1"),
//       //         Text("Suitable for students of ages 9-12")"),
//           // height: MediaQuery.of(context).size.height / 6,
//         ),
//         Padding(padding: EdgeInsets.all(10)),
//         SizedBox(
//           width: 320,
//                         child:DropdownButton<String>(
//                     items: _dropforms.map((String dropDownStringItem)
//                     {
//                        return DropdownMenuItem<String>(
//                           value: dropDownStringItem,
//                           child: Text(dropDownStringItem),

//                        );
//                     }).toList(),

//                     onChanged: (String newValueSelected){
//                       setState(() {
//                          _currentUser.group = newValueSelected;
//                         this._dropformSelected =newValueSelected;
//                       });
//                     },
//                     value: _dropformSelected,
//                     ),
//               ),
//         Padding(padding: EdgeInsets.all(20)),

//       ],
//     ),
//     // Container(
//     //     child: Title(
//     //       color: Colors.black,
//     //       child: Text("Select Group"),
//     //     ),
//     //   ),
//     // Text("Select Group"),
//       // GestureDetector(
//       //   onTap: (){
//       //     _currentUser.group = 'GroupA';
//       //      setState(() {
//       //       selected = true;
//       //     });
//       //   },
//       //           child: Container(
//       //             color: selected == true ? Colors.amber : Colors.grey,
//       //     height: MediaQuery.of(context).size.height / 3,
//       //     width: MediaQuery.of(context).size.width - 100,
//       //     child: Column(
//       //       children: <Widget>[
//       //         Text("Group A", style: Theme.of(context).textTheme.headline3),
//       //         Text("Suitable for students of ages 9-12")
//       //       ],
//       //     ),
//       //   ),
//       // ),

//       // GestureDetector(
//       //   onTap: () {
//       //     _currentUser.group = 'GroupB';
//       //     setState(() {
//       //       selected = true;
//       //     });
//       //   },
//       //           child: Container(
//       //             color: selected == true ? Colors.amber : Colors.grey,
//       //     height: MediaQuery.of(context).size.height / 3,
//       //     width: MediaQuery.of(context).size.width - 100,
//       //     child: Column(
//       //       children: <Widget>[
//       //         Text("Group B", style: Theme.of(context).textTheme.headline3),
//       //         Text("Suitable for students of ages 13-18")
//       //       ],
//       //     ),
//       //   ),
//       // ),
//       BottomAppBar(
//         child: GestureDetector(
//           onTap: () {
//               sendToServer();
//             //  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
//           },
//           child: Container(
//             width: MediaQuery.of(context).size.width - 50,
//             height: 62.5,
//             child: Center(
//               child: SizedBox(
//                 width: 100,
//                 child: submitLoading?Center(child: CircularProgressIndicator(
//                           backgroundColor: Colors.blue,
//                         )) :Text(
//                           'Submit',
//                           style: TextStyle(
//                               fontSize: 20,
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold),
//                           textAlign: TextAlign.center,
//                         ),
//               ),
//             ),
//             color: Colors.deepOrange,
//           ),
//         ),
//       )
//        ]
//     );

//   }

//   sendToServer() async {
//     // Users _user = Users();
//     if (_formKey.currentState.validate()) {
//       print(_currentUser.pinCode);
//       setState(() {
//          submitLoading=true;
//       });

//       // No any error in validation
//       _formKey.currentState.save();
//       print("CLicked successfully");
//       OurDatabase().createUser(_currentUser);
//       print("created user");
//       Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
//       setState(() {
//          submitLoading=false;
//       });

//       // Navigator.push(
//       //   context, MaterialPageRoute(builder: (context) => HomeScreen()));
//       // Navigator.pushNamed(context, "/dummy");
//     } else {
//       // validation error
//       setState(() {
//         _validate = true;
//       });
//     }
//   }
// }

// String validateName(String value) {
//   String pattern = r'(^[a-zA-Z ]*$)';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length <= 2) {
//     return "Name is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Name must be a-z and A-Z";
//   }
//   return null;
// }

// String validateSchool(String value) {
//   String pattern = r'(^[a-zA-Z ]*$)';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length <= 2) {
//     return "School Name is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Special characters not allowed";
//   }
//   return null;
// }

// String validateClass(String value) {
//   String pattern = '([0-2]{2}|[123456789])';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length == 0) {
//     return "Class is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Class must be between 1-12";
//   }
//   return null;
// }

// String validateCity(String value) {
//   String pattern = r'(^[a-zA-Z ]*$)';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length == 0) {
//     return "City is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Please enter a valid City";
//   }
//   return null;
// }

// String validateEmail(String value) {
//   String pattern =
//       r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
//   RegExp regExp = new RegExp(pattern);
//   if (value.length == 0) {
//     return "Email is Required";
//   } else if (!regExp.hasMatch(value)) {
//     return "Invalid Email";
//   } else {
//     return null;
//   }
// }

// String validatePhone(String value) {
// // Indian Mobile number are of 10 digit only
//   if (value.length != 10)
//     return 'Mobile Number must be of 10 digit';
//   else
//     return null;
// }
