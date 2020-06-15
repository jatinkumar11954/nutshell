import 'package:flutter/material.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/news.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/phone.dart';

import 'account.dart';

Widget bottomBar(BuildContext context, int index) {
  return SafeArea(
      child: BottomNavigationBar(
    
    backgroundColor: Colors.greenAccent,
    //  Colors.white,
    // elevation: 3,
    onTap: (index) {
      switch (index) {
        case 0:
          {
                             Navigator.push(context,MaterialPageRoute(builder: (context) => Paperbacks()));
            break;
          }
        case 1:
          {
            Navigator.push(context, MaterialPageRoute(builder: (context) =>News()));
            break;
          }

        case 2:
          {
                             Navigator.push(context, MaterialPageRoute(builder: (context) => Account()));
            break;
          }
      }
    },
    type: BottomNavigationBarType.fixed,
    currentIndex: index,
    items:
        //  <BottomNavigationBarItem>
        [
      BottomNavigationBarItem(
       icon: Icon(Icons.book),
        title: Text('Paperbacks'),
      ),
      BottomNavigationBarItem(
      icon: Icon(Icons.new_releases),
        title: Text('News'),),
      BottomNavigationBarItem(
         icon: Icon(Icons.account_circle),
        title: Text('Account'),
      ),
    ],
    // unselectedLabelStyle: TextStyle(color: Colors.white),
        selectedItemColor: Colors.purple,
    // fixedColor: 
    // Colors.grey,
    // Color.fromRGBO(127, 68, 0, .9),
      ),
  );
}