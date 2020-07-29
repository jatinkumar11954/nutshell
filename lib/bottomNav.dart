import 'package:flutter/material.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/news.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/phone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'account.dart';

// Widget bottomBar(BuildContext context, final index) {
//   return SafeArea(
//     child: BottomNavigationBar(
//       backgroundColor: Color.fromRGBO(191, 30, 46, 1),
//       //  Colors.white,
//       // elevation: 3,
//       onTap: (index) {
//         switch (index) {
//           case 0:
//             {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       maintainState: true, builder: (context) => Paperbacks()));
//               break;
//             }
//           case 1:
//             {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       maintainState: true, builder: (context) => News()));
//               break;
//             }

//           case 2:
//             {
//               Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                       maintainState: true, builder: (context) => Account()));
//               break;
//             }
//         }
//       },
//       type: BottomNavigationBarType.fixed,
//       currentIndex: index,
//       items: [
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             "assets/images/PAPERBACKICON.svg",
//             fit: BoxFit.contain,
//             height: 40,
//           ),
//           title: Text('Paperbacks'),
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             "assets/images/NEWSICON.svg",
//             fit: BoxFit.contain,
//             height: 40,
//           ),
//           title: Text('News'),
//         ),
//         BottomNavigationBarItem(
//           icon: SvgPicture.asset(
//             "assets/images/ACCOUNTICON.svg",
//             fit: BoxFit.contain,
//             height: 40,
//           ),
//           title: Text('Account'),
//         ),
//       ],
//       selectedItemColor: Colors.purple,
//     ),
//   );
// }

class BottomBar extends StatefulWidget {
  BottomBar({Key key}) : super(key: key);
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedItem = 0;
  static List<Widget> _navScreens = <Widget>[Paperbacks(), News(), Account()];
  void _onItemTapped(int index) {
    setState(() {
      _selectedItem = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _navScreens.elementAt(_selectedItem),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color.fromRGBO(191, 30, 46, 1),
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/PAPERBACKICON.svg",
              fit: BoxFit.contain,
              // color:Colors.red,
              height: 40,
            ),
            // Icon(Icons.book),
            title: Text('Paperbacks'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/NEWSICON.svg",
              fit: BoxFit.contain,
              // color:Colors.red,
              height: 40,
            ),
            title: Text('News'),
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              "assets/images/ACCOUNTICON.svg",
              fit: BoxFit.contain,
              // color:Colors.red,
              height: 40,
            ),
            title: Text('Account'),
          ),
        ],
        currentIndex: _selectedItem,
        selectedItemColor: Colors.purple,
        onTap: _onItemTapped,
      ),
    );
  }
}
