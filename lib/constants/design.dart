import 'package:flutter/material.dart';

const navigators = [
  '/add',
  '/',
  '/settings',
  '/timer'
];

Color mainDark = const Color.fromARGB(255, 0, 0, 0);
Color mainWhite = const Color.fromARGB(255, 227, 227, 227);
Color secondaryGray = const Color.fromARGB(255, 103, 103, 103);
Color secondaryDarkGray = Color.fromARGB(255, 63, 63, 63);
Color accentDarkRed = Color.fromARGB(255, 101, 0, 0);
Color accentRed = Color.fromARGB(255, 162, 8, 8);


ButtonStyle buttonStyle = ButtonStyle(
  padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15.0)),
  alignment: Alignment.center,
  backgroundColor: MaterialStateProperty.all<Color>(accentRed),
  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
  RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
    side: BorderSide(width:2, color: accentDarkRed),
  )
  )
);