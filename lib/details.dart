import 'package:flutter/material.dart';
import 'package:nutshell/orderConfirmation.dart';
import 'package:nutshell/users.dart';

import 'package:geolocator/geolocator.dart';
import 'database.dart';
import 'subscription.dart';

String phone;
String email;

TextEditingController _fnamecontroller = TextEditingController();
TextEditingController _lnamecontroller = TextEditingController();
TextEditingController _schoolcontroller = TextEditingController();
TextEditingController _classcontroller = TextEditingController();
TextEditingController _emailcontroller = TextEditingController();
TextEditingController _phonecontroller = TextEditingController();
TextEditingController _citycontroller = TextEditingController();
TextEditingController _pinCodecontroller = TextEditingController();

class Details extends StatefulWidget {
  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  bool isLoading=false;
  bool submitLoading=false;
  Users _currentUser = Users();
  Users get getCurrentUser => _currentUser;
    final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  _DetailsState({
    Key key,
  });

  bool _validate = false;
  @override
  void initState() {
    super.initState();
  }

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final text = TextEditingController();



  //  void callSnackBar(String msg,[int er])
  // {
    
  //     // msg="There is no record with this user, please register first by clicking Register";
  //   //  final SnackBar= new SnackBar(content: null)
  //     final SnackBar=new SnackBar(
  //     content: new Text(msg),
  //     duration: new Duration(seconds: 3),
  //   //   action: new SnackBarAction(label: "Register",
  //   //   onPressed: (){
  //   //     Navigator.pushNamed(context, "Register");
  //   //   },),
  //   );
  //    _scaffoldKey.currentState.showSnackBar(SnackBar);
  //   }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        iconTheme: IconThemeData(
          color: Colors.black,
          size: 80.0,
        ),
      ),
      body: Center(
        child: new Form(
          key: _formKey,
          autovalidate: _validate,
          child: FormUI(),
        ),
      ),
    );
  }

  // Widget GroupUi() {
  //   bool selected = false;
  //   return Column(
  //     mainAxisAlignment: MainAxisAlignment.center,
  //     crossAxisAlignment: CrossAxisAlignment.center,
  //     children: <Widget>[
  //       Container(
  //         child: Title(
  //           color: Colors.black,
  //           child: Text("Select Group"),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: (){
  //           _currentUser.group = 'GroupA';
  //            setState(() {
  //             selected = true;
  //           });
  //         },
  //                 child: Container(
  //                   color: selected == true ? Colors.amber : Colors.grey,
  //           height: MediaQuery.of(context).size.height / 3,
  //           width: MediaQuery.of(context).size.width - 100,
  //           child: Column(
  //             children: <Widget>[
  //               Text("Group A", style: Theme.of(context).textTheme.headline3),
  //               Text("Suitable for students of ages 9-12")
  //             ],
  //           ),
  //         ),
  //       ),
        
  //       GestureDetector(
  //         onTap: () {
  //           _currentUser.group = 'GroupB';
  //           setState(() {
  //             selected = true;
  //           });
  //         },
  //                 child: Container(
  //                   color: selected == true ? Colors.amber : Colors.grey,
  //           height: MediaQuery.of(context).size.height / 3,
  //           width: MediaQuery.of(context).size.width - 100,
  //           child: Column(
  //             children: <Widget>[
  //               Text("Group B", style: Theme.of(context).textTheme.headline3),
  //               Text("Suitable for students of ages 13-18")
  //             ],
  //           ),
  //         ),
  //       ),
  //       BottomAppBar(
  //         child: GestureDetector(
  //           onTap: () {
  //             sendToServer();
  //             //  Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
  //           },
  //           child: Container(
  //             width: MediaQuery.of(context).size.width - 50,
  //             height: 62.5,
  //             child: Center(
  //               child: SizedBox(
  //                 width: 100,
  //                 child: Text(
  //                   'Submit',
  //                   style: TextStyle(
  //                       fontSize: 20,
  //                       color: Colors.white,
  //                       fontWeight: FontWeight.bold),
  //                   textAlign: TextAlign.center,
  //                 ),
  //               ),
  //             ),
  //             color: Colors.deepOrange,
  //           ),
  //         ),
  //       )
  //     ],
  //   );
  // }
var _dropforms= [
   'Select Group','Group-A','Group-B'
  ]; 
  var _dropformSelected="Select Group";

  String pinCode;
  
  Geolocator geolocator = Geolocator();

   Future<Position> _getLocation() async {
    var currentLocation;
    try {
        currentLocation= await geolocator.getCurrentPosition(
          // desiredAccuracy: LocationAccuracy.best
        
        );
      // currentLocation = await geolocator.getCurrentPosition(
      //     // desiredAccuracy: LocationAccuracy.best
      //     );

          
       } catch (e) {
      currentLocation = null;
    }
    return currentLocation;
  }

  Widget FormUI() {
    

  Position userLocation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _getLocation().then((position) {
      userLocation = position;
      
    });
  }


  

  void callMe(Position userLocation)async{
    print("called for pLacemark");
    List<Placemark> placemark = await Geolocator().placemarkFromCoordinates(userLocation.latitude,userLocation.longitude);
    
    print(placemark[0].postalCode);
    setState(() {
      
    pinCode= placemark[0].postalCode;
    _currentUser.pinCode=placemark[0].postalCode;
    isLoading=false;
    });
    // print(placemark[0].name+placemark[0].administrativeArea+placemark[0].name+placemark[0].administrativeArea);
  }
  
     
    _currentUser.sID = sID;
     bool selected = false;
    return ListView(
       children: <Widget>[
         
     Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(
          width: MediaQuery.of(context).size.width - 100,
          child: Text(
            "Enter your Details",
            style: TextStyle(
              color: Colors.black,
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Padding(padding: EdgeInsets.all(20)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 140,
              child: TextFormField(
                  controller: _fnamecontroller,
                  
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Enter First Name'),
                  validator: validateName,
                  onSaved: (String value) {
                    _currentUser.fname = value;
                  }),
            ),
            SizedBox(
              width: 140,
              child: TextFormField(
                  controller: _lnamecontroller,
                  
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(labelText: 'Enter Last Name'),
                  validator: validateName,
                  onSaved: (String value) {
                    _currentUser.lname = value;
                  }),
            ),
          ],
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 320,
          child: TextFormField(
              controller: _schoolcontroller,
              
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Enter School Name'),
              validator: validateSchool,
              onSaved: (String value) {
                _currentUser.school = value;
              }),
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 320,
          child: TextFormField(
              controller: _classcontroller,
              
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Enter Class'),
              validator: validateClass,
              onSaved: (String value) {
                _currentUser.grade = value;
              }),
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 320,
          child: TextFormField(
              controller: _emailcontroller,
              
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(labelText: 'Enter Email Address'),
              validator: validateEmail,
              onSaved: (String value) {
                _currentUser.email = value;
                email = value;
              }),
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 320,
          child: TextFormField(
              controller: _citycontroller,
              
              keyboardType: TextInputType.text,
              decoration: InputDecoration(labelText: 'Enter City'),
              validator: validateCity,
              onSaved: (String value) {
                _currentUser.city = value;
              }),
        ),
        Padding(padding: EdgeInsets.all(10)),
        
        SizedBox(
           width: 320,
           child:Row(
             children: <Widget>[
              SizedBox(
          width: MediaQuery.of(context).size.width/3,
          child: TextFormField(
              controller: _pinCodecontroller,
              
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                hintText: _currentUser.pinCode==null?pinCode:"",
                labelText: pinCode==null?'Enter Pincode':pinCode),
              // validator: validateCity,
              onSaved: (String value) {
                _currentUser.pinCode = value;
              }),
        ),
              Text("Or use Auto Locate  ",style: TextStyle(fontSize: 15.0),),
              InkWell(
              child: isLoading?CircularProgressIndicator():
              Icon(
                 Icons.my_location,
                 color: Colors.green,
                 size: 40,
                //  my_location
               ),
               onTap: ()async{
                 setState(() {
                      isLoading=true;
                      });
                 _getLocation().then((value) {
                    setState(() {
                      // isLoading=true;
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
        Padding(padding: EdgeInsets.all(10)),
        SizedBox(
          width: 320,
          child: TextFormField(
              controller: _phonecontroller,
              
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                  labelText: 'Enter Phone Number', prefix: Text("+91")),
              validator: validatePhone,
              onSaved: (String value) {
                _currentUser.phone = value;
                phone = value;
              }),
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox( 
          width: 320,
          child: Text("Select Group\n1.Group A Suitable for students of ages 9-12\n2.Suitable for students of ages 13-1"),
      //         Text("Suitable for students of ages 9-12")"),
          // height: MediaQuery.of(context).size.height / 6,
        ),
        Padding(padding: EdgeInsets.all(10)),
        SizedBox( 
          width: 320,
                        child:DropdownButton<String>(
                    items: _dropforms.map((String dropDownStringItem)
                    {
                       return DropdownMenuItem<String>(
                          value: dropDownStringItem,
                          child: Text(dropDownStringItem),

                       );
                    }).toList(),
                    onChanged: (String newValueSelected){
                      setState(() {
                         _currentUser.group = newValueSelected;
                        this._dropformSelected =newValueSelected;
                      });
                    },
                    value: _dropformSelected,
                    ),
              ),
        Padding(padding: EdgeInsets.all(20)),
        


      ],
    ),
    // Container(
    //     child: Title(
    //       color: Colors.black,
    //       child: Text("Select Group"),
    //     ),
    //   ),
    // Text("Select Group"),
      // GestureDetector(
      //   onTap: (){
      //     _currentUser.group = 'GroupA';
      //      setState(() {
      //       selected = true;
      //     });
      //   },
      //           child: Container(
      //             color: selected == true ? Colors.amber : Colors.grey,
      //     height: MediaQuery.of(context).size.height / 3,
      //     width: MediaQuery.of(context).size.width - 100,
      //     child: Column(
      //       children: <Widget>[
      //         Text("Group A", style: Theme.of(context).textTheme.headline3),
      //         Text("Suitable for students of ages 9-12")
      //       ],
      //     ),
      //   ),
      // ),
      
      // GestureDetector(
      //   onTap: () {
      //     _currentUser.group = 'GroupB';
      //     setState(() {
      //       selected = true;
      //     });
      //   },
      //           child: Container(
      //             color: selected == true ? Colors.amber : Colors.grey,
      //     height: MediaQuery.of(context).size.height / 3,
      //     width: MediaQuery.of(context).size.width - 100,
      //     child: Column(
      //       children: <Widget>[
      //         Text("Group B", style: Theme.of(context).textTheme.headline3),
      //         Text("Suitable for students of ages 13-18")
      //       ],
      //     ),
      //   ),
      // ),
      BottomAppBar(
        child: GestureDetector(
          onTap: () {
              sendToServer();
             Navigator.push(context, MaterialPageRoute(builder: (context) => OrderConfirmation()));
          },
          child: Container(
            width: MediaQuery.of(context).size.width - 50,
            height: 62.5,
            child: Center(
              child: SizedBox(
                width: 100,
                child: submitLoading?Center(child: CircularProgressIndicator(
                          backgroundColor: Colors.blue,
                        )) :Text(
                          'Submit',
                          style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
              ),
            ),
            color: Colors.deepOrange,
          ),
        ),
      )
       ]
    );
    
  }

  sendToServer() async {
    // Users _user = Users();
    if (_formKey.currentState.validate()) {
      print(_currentUser.pinCode);
      setState(() {
         submitLoading=true;
      });
     
      // No any error in validation
      _formKey.currentState.save();
      print("CLicked successfully");
      OurDatabase().createUser(_currentUser);
      print("created user");
      setState(() {
         submitLoading=false;
      });
     
      // Navigator.push(
      //   context, MaterialPageRoute(builder: (context) => HomeScreen()));
      // Navigator.pushNamed(context, "/dummy");
    } else {
      // validation error
      setState(() {
        _validate = true;
      });
    }
  }
}

String validateName(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length <= 2) {
    return "Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Name must be a-z and A-Z";
  }
  return null;
}

String validateSchool(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length <= 2) {
    return "School Name is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Special characters not allowed";
  }
  return null;
}

String validateClass(String value) {
  String pattern = '([0-2]{2}|[123456789])';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Class is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Class must be between 1-12";
  }
  return null;
}

String validateCity(String value) {
  String pattern = r'(^[a-zA-Z ]*$)';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "City is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Please enter a valid City";
  }
  return null;
}

String validateEmail(String value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regExp = new RegExp(pattern);
  if (value.length == 0) {
    return "Email is Required";
  } else if (!regExp.hasMatch(value)) {
    return "Invalid Email";
  } else {
    return null;
  }
}

String validatePhone(String value) {
// Indian Mobile number are of 10 digit only
  if (value.length != 10)
    return 'Mobile Number must be of 10 digit';
  else
    return null;
}
