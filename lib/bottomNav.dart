import 'package:flutter/material.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/news.dart';
import 'package:nutshell/paperback.dart';
import 'package:nutshell/phone.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:persistent_bottom_nav_bar/models/persistent-nav-bar-scaffold.widget.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'account.dart';

Widget bottomBar(BuildContext context, final index) {
  return SafeArea(
    child: BottomNavigationBar(
      backgroundColor: Color.fromRGBO(191, 30, 46, 1),
      //  Colors.white,
      // elevation: 3,
      onTap: (index) {
        switch (index) {
          case 0:
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      maintainState: true, builder: (context) => Paperbacks()));
              break;
            }
          case 1:
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      maintainState: true, builder: (context) => News()));
              break;
            }

          case 2:
            {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      maintainState: true, builder: (context) => Account()));
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
      // unselectedLabelStyle: TextStyle(color: Colors.white),
      selectedItemColor: Colors.purple,
      // fixedColor:
      // Colors.grey,
      // Color.fromRGBO(127, 68, 0, .9),
    ),
  );
}
// Widget bottomBar(BuildContext context, int index) {
//   List<PersistentBottomNavBarItem> _navBarItems() {
//     return [
//       PersistentBottomNavBarItem(
//           icon: SvgPicture.asset('assets/images/PAPERBACKICON.svg'),
//           title: 'Paperbacks',
//           activeColor: Colors.purple,
//           inactiveColor: Colors.white),
//       PersistentBottomNavBarItem(
//           icon: SvgPicture.asset('assets/images/NEWSICON.svg'),
//           title: 'News',
//           activeColor: Colors.purple,
//           inactiveColor: Colors.white),
//       PersistentBottomNavBarItem(
//           icon: SvgPicture.asset('assets/images/ACCOUNTICON.svg'),
//           title: 'Account',
//           activeColor: Colors.purple,
//           inactiveColor: Colors.white),
//     ];
//   }

//   List<Widget> _buildScreens() {
//     return [Paperbacks(), News(), Account()];
//   }

//   PersistentTabController _controller =
//       PersistentTabController(initialIndex: 0);
//   return PersistentTabView(
//     controller: _controller,
//     items: _navBarItems(),
//     screens: _buildScreens(),
//     iconSize: 26.0,
//     showElevation: true,
//     navBarCurve: NavBarCurve.upperCorners,
//     confineInSafeArea: true,
//     onItemSelected: (index) {
//       switch (index) {
//         case 0:
//           {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => Paperbacks()));
//             break;
//           }
//         case 1:
//           {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => News()));
//             break;
//           }

//         case 2:
//           {
//             Navigator.push(
//                 context, MaterialPageRoute(builder: (context) => Account()));
//             break;
//           }
//       }
//     },
//     navBarStyle: NavBarStyle.style1,
//   );
// }
class PersistentNavBar extends StatefulWidget {
  @override
  _PersistentNavBarState createState() => _PersistentNavBarState();
}

class _PersistentNavBarState extends State<PersistentNavBar> {
  List<PersistentBottomNavBarItem> _navBarItems() {
    return [
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/images/PAPERBACKICON.svg'),
          title: 'Paperbacks',
          activeColor: Colors.purple,
          inactiveColor: Colors.white),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/images/NEWSICON.svg'),
          title: 'News',
          activeColor: Colors.purple,
          inactiveColor: Colors.white),
      PersistentBottomNavBarItem(
          icon: SvgPicture.asset('assets/images/ACCOUNTICON.svg'),
          title: 'Account',
          activeColor: Colors.purple,
          inactiveColor: Colors.white),
    ];
  }

  List<Widget> _buildScreens() {
    return [Paperbacks(), News(), Account()];
  }

  PersistentTabController controller = PersistentTabController(initialIndex: 0);

  @override
  Widget build(BuildContext context) {
    return PersistentTabView(
      controller: controller,
      items: _navBarItems(),
      screens: _buildScreens(),
      iconSize: 26.0,
      showElevation: true,
      navBarCurve: NavBarCurve.upperCorners,
      confineInSafeArea: true,
      onItemSelected: (index) {
        setState(() {
          controller.index = index;
        });
      },
      navBarStyle: NavBarStyle.style5,
    );
    // List <Widget> _navBarItems[]
  }
}

class BottomBar extends StatefulWidget {
  @override
  _BottomBarState createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _currentIndex = 0;
  onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Color.fromRGBO(191, 30, 46, 1),
      type: BottomNavigationBarType.fixed,
      items: [
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/images/PAPERBACKICON.svg",
            fit: BoxFit.contain,
            height: 40,
          ),
          title: Text('Paperbacks'),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/images/NEWSICON.svg",
            fit: BoxFit.contain,
            height: 40,
          ),
          title: Text('News'),
        ),
        BottomNavigationBarItem(
          icon: SvgPicture.asset(
            "assets/images/ACCOUNTICON.svg",
            fit: BoxFit.contain,
            height: 40,
          ),
          title: Text('Account'),
        ),
      ],
      selectedItemColor: Colors.purple,
    );
  }
}
