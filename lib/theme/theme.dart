import 'package:flutter/material.dart';

class AppThemes {
  // Açık Tema
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: const Color(0xFF00ADB5), // Vurgu rengi
    secondaryHeaderColor: const Color(0xFF222831),
    scaffoldBackgroundColor: const Color(0xFFEEEEEE), // Ana arka plan
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Color(0xFF222831)), // Metin rengi
      bodySmall: TextStyle(color: Colors.grey), // Metin rengi
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF00ADB5), // AppBar arka plan
      foregroundColor: Colors.white, // AppBar yazı ve ikon
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00ADB5), // Buton arka planı
        foregroundColor: Colors.white, // Buton yazı rengi
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF393E46), // Buton arka planı
      foregroundColor: Colors.white,
    ),
    cardTheme: const CardTheme(
      color: Colors.white,
    ),
    //textField form kısmı
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // TextField arka planı
      fillColor: Colors.white, // Arka plan rengi
      labelStyle: const TextStyle(color: Colors.grey), // Label rengi
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
            color: Color(0xFF00ADB5), width: 2.0), // Focus durumunda
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide:
            const BorderSide(color: Colors.grey, width: 1.0), // Default border
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );

  // Koyu Tema
  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF00ADB5), // Vurgu rengi
    scaffoldBackgroundColor: const Color(0xFF393E46), // Ana arka plan
    textTheme: const TextTheme(
      bodyMedium: TextStyle(color: Color(0xFFEEEEEE)), // Metin rengi
      bodySmall: TextStyle(color: Colors.grey), // Metin rengi
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF222831), // AppBar arka plan
      foregroundColor: Colors.white, // AppBar yazı ve ikon
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFF00ADB5), // Buton arka planı
        foregroundColor: Colors.white, // Buton yazı rengi
      ),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF00ADB5), // Buton arka planı
      foregroundColor: Colors.white,
    ),
    cardTheme: const CardTheme(
      color: Color(0xFF222831),
    ),
    //textField form kısmı
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800], // Koyu arka plan
      labelStyle: const TextStyle(color: Colors.white70),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.circular(10),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.white54, width: 1.0),
        borderRadius: BorderRadius.circular(10),
      ),
    ),
  );
}
