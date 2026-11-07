import 'package:flutter/material.dart';
import 'screens/main_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // ═══ PORSCHE BRAND PALETTE ═══
  static const Color porscheRed = Color(0xFFD5001C);
  static const Color porscheBlack = Color(0xFF111111);
  static const Color porscheDarkGrey = Color(0xFF1A1A1A);
  static const Color porscheGold = Color(0xFFC5A059);
  static const Color porscheSilver = Color(0xFFB0B0B0);
  static const Color porscheCream = Color(0xFFF5F3EF);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ATS Pemrograman IV - Keyla Sun',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily: 'Oswald',
        scaffoldBackgroundColor: porscheCream,
        colorScheme: ColorScheme.fromSeed(
          seedColor: porscheRed,
          primary: porscheRed,
          secondary: porscheBlack,
          surface: Colors.white,
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: porscheBlack,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w700,
            fontSize: 18,
            letterSpacing: 3,
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            textStyle: const TextStyle(
              fontFamily: 'Oswald',
              fontWeight: FontWeight.w600,
              letterSpacing: 1,
            ),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4),
            ),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.black12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: porscheRed, width: 2),
          ),
          labelStyle: const TextStyle(
            fontFamily: 'Oswald',
            fontWeight: FontWeight.w400,
            letterSpacing: 0.5,
          ),
        ),
        cardTheme: CardThemeData(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        useMaterial3: true,
      ),
      home: const MainScreen(),
    );
  }
}
