import 'package:flutter/material.dart';

class MyTheme {
  static List<BoxShadow> customShodowforCircle = [
    BoxShadow(
      color: Colors.white.withOpacity(0.5),
      spreadRadius: -5,
      offset: Offset(-5, -5),
      blurRadius: 30,
    ),
    BoxShadow(
      color: Colors.blue[900].withOpacity(0.2),
      spreadRadius: 2,
      offset: Offset(7, 7),
      blurRadius: 20,
    )
  ];
  static ThemeData lightTheme = ThemeData(
      appBarTheme: AppBarTheme(
          color: Colors.black,
          textTheme: TextTheme(
              headline1: TextStyle(
                color: Colors.white,
              ),
              bodyText1: TextStyle(color: Colors.white))),
      scaffoldBackgroundColor: Colors.white,
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white)),
      iconTheme: IconThemeData(color: Colors.white),
      bottomNavigationBarTheme:
          BottomNavigationBarThemeData(backgroundColor: Colors.black));
  static ThemeData darkTheme = ThemeData();
}
