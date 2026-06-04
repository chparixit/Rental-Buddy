import 'package:flutter/material.dart';
import 'package:rental_buddy/features/auth/presentation/screens/register_screen.dart';
import 'package:rental_buddy/features/splash/splash_screen.dart';
import 'package:rental_buddy/themes/theme_data.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental Buddy',

      theme: AppTheme.lightTheme, 

      home: const SplashScreen(),

      routes: {
        '/splash': (context) => const SplashScreen(),
        '/register': (context) => const RegisterScreen(),
      },
    );
  }
}