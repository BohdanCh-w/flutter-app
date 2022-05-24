import 'package:flutter/material.dart';
import 'package:savvy_time/constants/design.dart';

class Navigation extends StatefulWidget {
  int selectedIndex;
  Navigation({Key? key, required this.selectedIndex}) : super(key: key);
  @override
  State<Navigation> createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      selectedItemColor: accentRed,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.add),
          label: 'Add location',
          backgroundColor: mainDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
          backgroundColor: mainDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.settings),
          label: 'Settings',
          backgroundColor: mainDark,
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.timer),
          label: 'Timer',
          backgroundColor: mainDark,
        ),
      ],
      currentIndex: widget.selectedIndex,
      //selectedItemColor: Colors.amber[800],
      onTap: (int index) {
        setState(() {
          widget.selectedIndex = index;
        });
        Navigator.pushNamed(context, navigators[index]);
      },
    );
  }
}
