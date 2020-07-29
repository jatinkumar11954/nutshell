import 'package:flutter/material.dart';
import 'package:nutshell/AccountModule.dart/extendorder.dart';
import 'package:nutshell/AccountModule.dart/extendplan.dart';
import 'package:nutshell/AccountModule.dart/help.dart';
import 'package:nutshell/bottomNav.dart';
import 'package:nutshell/details.dart';
import 'package:nutshell/dummy.dart';
import 'package:nutshell/model/userdetails.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/login.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/splashscreen.dart';
import 'package:flutter/services.dart';
import 'package:nutshell/subscription.dart';
import 'package:provider/provider.dart';
import 'AccountModule.dart/contactUs.dart';
import 'AccountModule.dart/pricing.dart';
import 'AccountModule.dart/privacy.dart';
import 'AccountModule.dart/refund.dart';
import 'AccountModule.dart/termsandconditions.dart';
import 'Otp.dart';
import 'editprofilescreen.dart';
import 'account.dart';
import 'AccountModule.dart/aboutUs.dart';
import 'orderConfirmation.dart';

void main() {
  runApp(MyApp());
  SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => UserDetails(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        routes: <String, WidgetBuilder>{
          '/paperback': (BuildContext context) => Paperbacks(),
          '/Login': (BuildContext context) => LoginScreen(),
          '/details': (BuildContext context) => Details(),
          '/subs': (BuildContext context) => Subscription(),
          '/intro': (BuildContext context) => IntroScreen(),
          'otp': (BuildContext context) => Otp(),
          '/dummy': (BuildContext context) => DummyScreen(),
          '/account': (BuildContext context) => Account(),
          // '/about': (BuildContext context) => About(),
          '/help': (BuildContext context) => Help(),
          '/contact': (BuildContext context) => ContactUs(),
          '/pricing': (BuildContext context) => Pricing(),
          '/privacy': (BuildContext context) => Privacy(),
          '/refund': (BuildContext context) => Refund(),
          '/termsandconditions': (BuildContext context) => TermsAndConditions(),
          '/editprofile': (BuildContext context) => EditProfileScreen(),
          '/aboutUs': (BuildContext context) => AboutUs(),
          '/orderConfirm': (BuildContext context) => OrderConfirmation(),
          '/bottombar': (BuildContext context) => BottomBar(),
          // '/name': (BuildContext context) => new NameScreen(),
          '/email': (BuildContext context) => new Email(),
          '/birth': (BuildContext context) => new BirthDay(),
          '/instution': (BuildContext context) => new Instution(),
          '/pincode': (BuildContext context) => new PinCode(),
          '/paperback': (BuildContext context) => Paperbacks(),
          '/group': (BuildContext context) => GroupScreen(),
          '/account': (BuildContext context) => Account(),
          // '/about': (BuildContext context) => About(),
          '/help': (BuildContext context) => Help(),
          '/contact': (BuildContext context) => ContactUs(),
          '/pricing': (BuildContext context) => Pricing(),
          '/privacy': (BuildContext context) => Privacy(),
          '/refund': (BuildContext context) => Refund(),
          '/termsandconditions': (BuildContext context) => TermsAndConditions(),
          '/editprofile': (BuildContext context) => EditProfileScreen(),
          '/aboutUs': (BuildContext context) => AboutUs(),
          '/extendplan': (BuildContext context) => Extend(),
          '/extendorder': (BuildContext context) => ExtendOrder()
          //'/': (BuildContext context) => Details(),
        },
        title: 'Nutshell',
        theme: ThemeData(
            fontFamily: 'Montserret',
            primarySwatch: Colors.deepOrange,
            // visualDensity: VisualDensity.adaptivePlatformDensity,
            textTheme: TextTheme(
                headline1: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                subtitle2: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                subtitle1: TextStyle(fontSize: 20, color: Colors.black))),
        home:
            //  IntroScreen()
            Splash(),

        //  OrderConfirmation(),
        // AboutUs()
        // Details()
        // IntroScreen()
        // Paperbacks(),
        // LoginScreen(),
      ),
    );
  }
}
