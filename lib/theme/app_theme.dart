import 'package:flutter/material.dart';

class AppTheme {
  // static const Color primaryColor = Color.fromRGBO(214, 48, 49, 1);
  static const Color primaryColor = Color.fromRGBO(179, 57, 57, 1.0);

  static const Color secundaryColor = Color.fromARGB(255, 216, 216, 216);
  static final ThemeData theme = ThemeData.light().copyWith(
    primaryColor: primaryColor,
    scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
    //*App bar
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      color: primaryColor,
      iconTheme: IconThemeData(color: Colors.white),
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(backgroundColor: primaryColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppTheme.primaryColor,
        foregroundColor: Colors.white,
      ),
    ),
  );

  //*----------- INPUT DECORATION -------------

  static InputDecoration normalInputDecoration({
    required String labelText,
    String hintText = '',
  }) {
    return InputDecoration(
      labelText: labelText,
      hintText: hintText,
      labelStyle: const TextStyle(color: primaryColor),
      border: const UnderlineInputBorder(
        borderSide: BorderSide(color: Colors.red),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: AppTheme.primaryColor, width: 2.0),
      ),
      focusColor: primaryColor,
    );
  }

  //*---------- box decoration--------
  static BoxDecoration boxDecoration = BoxDecoration(
    borderRadius: BorderRadius.circular(10),
  );

  static BoxDecoration boxDecorationInfoCards = BoxDecoration(
    borderRadius: BorderRadius.circular(40),
    // borderRadius: BorderSta,
    boxShadow: [boxShadowCards],
    color: primaryColor,
  );

  static BoxDecoration simpleCardDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(25),
    boxShadow: [BoxShadow(color: Colors.black26, blurRadius: 15)],
  );
  //*----------- SHADOW -------------

  static BoxShadow boxShadowCards = const BoxShadow(
    color: Colors.black12,
    blurRadius: 10,
  );

  //*----------- TextStyles -------------
  static TextStyle titleStyle = const TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
  );
}
