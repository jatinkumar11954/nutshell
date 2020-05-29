import 'package:flutter/material.dart';
import 'package:nutshell/paperback.dart';
import 'account.dart';
import 'news.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
 
  int _selectedIndex = 0;
static List<Widget> _widgetOptions = <Widget>[
  Paperbacks(),
  News(),
  Account(),
];

void _onItemTapped(int index) {
  setState(() {
    _selectedIndex = index;
  });
}

  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: PageView(
        scrollDirection: Axis.horizontal,
        children: [
         Center(child: _widgetOptions.elementAt(_selectedIndex),
         )
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.greenAccent,
        items:const <BottomNavigationBarItem>[
           BottomNavigationBarItem(
          icon: Icon(Icons.book),
          title: Text('Paperbacks'),
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.new_releases),
          title: Text('News'),
        ),
       
        BottomNavigationBarItem(
          icon: Icon(Icons.account_circle),
          title: Text('Account'),
        ),
      ],
       currentIndex: _selectedIndex,
      selectedItemColor: Colors.purple,
      onTap: _onItemTapped,
      ),

    );
  }
}