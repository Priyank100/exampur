import 'package:flutter/material.dart';

CustomTheme currentTheme = CustomTheme();

class CustomTheme with ChangeNotifier {
  static bool _isDarkTheme = false;

  // Todo: figure out how to implement ThemeMode.system

  // onPressed: (BuildContext context) {
  // currentTheme.toggleTheme();
  // }, this is how to toggle between the themes

  //ThemeMode get currentTheme => _isDarkTheme ? ThemeMode.dark : ThemeMode.light;
  ThemeMode get currentTheme => ThemeMode.dark;

  void toggleTheme() {
    _isDarkTheme = !_isDarkTheme;
    notifyListeners();
  }

  static ThemeData get lightTheme {
    return ThemeData(
      hintColor: Color(0xff0670ED),
      brightness: Brightness.light,
      primaryColor: Color(0xffFFD331),
      secondaryHeaderColor: Color(0xFFE1EFFE),
      accentColor: Color(0xff0670ED),
      scaffoldBackgroundColor: Color(0xffF6F7F9),
      backgroundColor: Colors.white,
      shadowColor: Colors.grey.withOpacity(0.5),
      dividerColor: Colors.black,
      iconTheme: IconThemeData(color: Colors.black),
      primaryIconTheme: IconThemeData(color: Colors.black),
      appBarTheme: AppBarTheme(
        elevation: 5,
        backgroundColor: Color(0xff0670ED),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.black,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme: TextTheme(),
    );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      hintColor: Color(0xff0670ED),
      brightness: Brightness.dark,
      primaryColor: Color(0xffFFD331),
      secondaryHeaderColor: Color(0xFFE1EFFE),
      accentColor:  Color(0xff0670ED),//Color(0xFF808080),
      scaffoldBackgroundColor: Color(0xff262626),
      //Color(0xff1a1a1a),
      backgroundColor: Color(0xff1a1a1a),
      //Color(0xff0d0d0d), //Colors.black,
      shadowColor: Colors.grey.withOpacity(0.5),
      dividerColor: Color(0xFF5E5E5E),
      iconTheme: IconThemeData(color: Colors.white),
      primaryIconTheme: IconThemeData(color: Colors.white),
      appBarTheme: AppBarTheme(
        elevation: 5,
        backgroundColor: Color(0xff0670ED),
        textTheme: TextTheme(
          headline6: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      fontFamily: 'Poppins',
      textTheme: TextTheme(),
    );
  }
}