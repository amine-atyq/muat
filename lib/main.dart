import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';
import 'package:muat/screens/home_screen.dart';

final colorScheme = ColorScheme.fromSeed(
  seedColor: const Color.fromARGB(255, 00, 45, 95),
  brightness: Brightness.light,
  primary: const Color.fromARGB(255, 228, 37, 24),
  secondary: const Color.fromARGB(255, 13, 105, 56),
  background: Colors.white,
);

final theme = ThemeData().copyWith(
  useMaterial3: true,
  scaffoldBackgroundColor: colorScheme.background,
  colorScheme: colorScheme,
  textTheme: GoogleFonts.robotoTextTheme(),
);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: theme,
      home: const HomeScreen(),
    );
  }
}
