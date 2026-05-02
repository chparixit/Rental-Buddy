import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(const RentalBuddyApp());
}

class RentalBuddyApp extends StatelessWidget {
  const RentalBuddyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Rental Buddy',
      theme: ThemeData(
        fontFamily: 'Poppins',
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int currentDot = 0;

  @override
  void initState() {
    super.initState();

    // Auto slide dots animation
    Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentDot = (currentDot + 1) % 3;
      });
    });

    // Navigate after 4 sec
    Future.delayed(const Duration(seconds: 4), () {
      // Navigator.pushReplacement(context,
      // MaterialPageRoute(builder: (_) => LoginScreen()));
    });
  }

  Widget buildDot(int index) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: 14,
      height: 14,
      decoration: BoxDecoration(
        color: currentDot == index
            ? Colors.blue.shade700
            : Colors.blue.shade100,
        shape: BoxShape.circle,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF3F4F6),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28),
          child: Column(
            children: [
              const SizedBox(height: 90),

              /// Logo Box
              Container(
                width: 110,
                height: 110,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(28),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.25),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.home_work_rounded,
                  color: Colors.white,
                  size: 52,
                ),
              ),

              const SizedBox(height: 30),

              /// Title
              const Text(
                "Rental Buddy",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "Find Your Perfect Home in the Valley",
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 40),

              /// Location Chip
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.location_on_outlined,
                        color: Colors.blue, size: 22),
                    SizedBox(width: 8),
                    Text(
                      "KATHMANDU, NEPAL",
                      style: TextStyle(
                        fontSize: 18,
                        letterSpacing: 1.5,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// Dots Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  buildDot(0),
                  buildDot(1),
                  buildDot(2),
                ],
              ),

              const SizedBox(height: 35),

              /// Get Started Button
              SizedBox(
                width: double.infinity,
                height: 68,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                    elevation: 6,
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              /// Sign In
              TextButton(
                onPressed: () {},
                child: Text(
                  "Sign In to Account",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.blue.shade800,
                  ),
                ),
              ),

              const SizedBox(height: 50),

              const Text(
                "PREMIUM PROPERTY PORTAL",
                style: TextStyle(
                  fontSize: 16,
                  letterSpacing: 3,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}