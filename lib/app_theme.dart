import 'package:flutter/material.dart';

class AppThemes {
  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    scaffoldBackgroundColor: Colors.blue[50],
    colorScheme: ColorScheme.light(
      primary: Colors.blue,
      secondary: Colors.white,
      surface: Colors.white, // Warna container saat light mode
      onSurface: Colors.black, // Warna teks di atas surface
    ),
    textTheme: TextTheme(
      titleLarge: const TextStyle(color: Colors.white),
      titleSmall: const TextStyle(color: Colors.blueGrey),
      bodySmall: TextStyle(color: Colors.blue[50]!),
      bodyMedium: const TextStyle(color: Colors.black),
      bodyLarge: const TextStyle(color: Colors.black),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.blue,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.blue[50], // Warna background TextField saat gelap
      labelStyle: const TextStyle(
        color: Colors.black,
      ), // Warna label saat gelap
      hintStyle: const TextStyle(
        color: Colors.black45,
      ), // Warna hint saat gelap
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),
    //elevated button
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white, // << tambahkan ini
      ),
    ),
  );

  static final ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey[900],
    scaffoldBackgroundColor: Colors.black,
    colorScheme: ColorScheme.dark(
      primary: Colors.black38,
      secondary: Colors.grey[850]!,
      surface: Colors.black, // Warna container saat dark mode
      onSurface: Colors.white, // Warna teks di atas surface
    ),
    textTheme: TextTheme(
      titleLarge: const TextStyle(color: Colors.black),
      titleSmall: const TextStyle(color: Colors.white),
      bodySmall: TextStyle(color: Colors.blue[50]!),
      bodyMedium: const TextStyle(color: Colors.white),
      bodyLarge: const TextStyle(color: Colors.white),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black,
      titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.grey[800], // Warna background TextField saat gelap
      labelStyle: const TextStyle(
        color: Colors.white,
      ), // Warna label saat gelap
      hintStyle: const TextStyle(
        color: Colors.white70,
      ), // Warna hint saat gelap
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide.none,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black, // teks hitam agar kontras
      ),
    ),
  );
}
