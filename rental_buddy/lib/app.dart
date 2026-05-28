import 'package:flutter/material.dart';
import 'package:rental_buddy/themes/theme_data.dart';
import 'package:rental_buddy/view/splash_screen.dart';
import 'screens/register_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental Buddy',

      theme: AppTheme.lightTheme, // 👈 no parentheses, no parameters

      home: const SplashScreen(),

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}