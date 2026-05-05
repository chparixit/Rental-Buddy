import 'dart:async';
import 'package:flutter/material.dart';
import '../auth/register_screen.dart';

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
      theme: ThemeData(fontFamily: 'Poppins', primarySwatch: Colors.blue),
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
  Timer? timer;
  bool isPressed = false;

  @override
  void initState() {
    super.initState();

    /// Faster dot animation
    timer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (mounted) {
        setState(() {
          currentDot = (currentDot + 1) % 3;
        });
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  void goToRegister() async {
    setState(() {
      isPressed = true;
    });

    await Future.delayed(const Duration(milliseconds: 200));

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (_) => const RegisterScreen()),
    );
  }

  Widget buildDot(int index) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      margin: const EdgeInsets.symmetric(horizontal: 4),
      width: currentDot == index ? 18 : 10,
      height: 10,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentDot == index
            ? Colors.blue.shade800
            : Colors.blue.shade100,
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
              const SizedBox(height: 80),

              /// Logo
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue.shade800,
                  borderRadius: BorderRadius.circular(24),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(.25),
                      blurRadius: 15,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.home_work_rounded,
                  color: Colors.white,
                  size: 50,
                ),
              ),

              const SizedBox(height: 25),

              const Text(
                "Rental Buddy",
                style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 8),

              const Text(
                "Find Your Perfect Home in the Valley",
                style: TextStyle(fontSize: 16, color: Colors.black54),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 35),

              /// Location Chip
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  border: Border.all(color: Colors.grey.shade300),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.location_on_outlined, color: Colors.blue),
                    SizedBox(width: 8),
                    Text(
                      "KATHMANDU, NEPAL",
                      style: TextStyle(
                        fontSize: 16,
                        letterSpacing: 1.2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              /// Dots
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [buildDot(0), buildDot(1), buildDot(2)],
              ),

              const SizedBox(height: 30),

              /// Get Started Button
              AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: double.infinity,
                height: 65,
                transform: Matrix4.identity()..scale(isPressed ? 0.96 : 1.0),
                child: ElevatedButton(
                  onPressed: goToRegister,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: isPressed ? 2 : 8,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),
                  child: const Text(
                    "Get Started",
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              const Text(
                "PREMIUM PROPERTY PORTAL",
                style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 3,
                  color: Colors.grey,
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }
}
