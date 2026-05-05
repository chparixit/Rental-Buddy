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
        fontFamily: 'Arial',
        scaffoldBackgroundColor: const Color(0xFFF5F6F8),
      ),
      home: const RegisterScreen(),
    );
  }
}

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            children: [
              const SizedBox(height: 12),

              /// Top Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.location_on_outlined,
                        color: Colors.blue,
                        size: 28,
                      ),
                      SizedBox(width: 8),
                      Text(
                        "Rental Buddy",
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      "Login",
                      style: TextStyle(color: Colors.blue, fontSize: 18),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              /// Main Card
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 28,
                  vertical: 30,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(28),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Create Account",
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Register to start your property journey in\nthe capital.",
                      style: TextStyle(
                        fontSize: 17,
                        color: Colors.black54,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),

                    buildLabel("FULL NAME"),
                    buildTextField(
                      hint: 'Enter your full name',
                      icon: Icons.person_outline,
                    ),

                    buildLabel("EMAIL"),
                    buildTextField(
                      hint: 'Enter your email address',
                      icon: Icons.mail_outline,
                    ),

                    buildLabel("PHONE"),
                    buildTextField(
                      hint: 'Enter your phone number',
                      icon: Icons.phone_outlined,
                    ),

                    buildLabel("PASSWORD"),
                    buildTextField(
                      hint: 'Enter your password',
                      icon: Icons.lock_outline,
                      obscure: true,
                    ),

                    buildLabel("CONFIRM PASSWORD"),
                    buildTextField(
                      hint: 'Confirm your password',
                      icon: Icons.lock_reset_outlined,
                      obscure: true,
                    ),

                    const SizedBox(height: 30),

                    /// Button
                    SizedBox(
                      width: double.infinity,
                      height: 58,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          elevation: 6,
                          shadowColor: Colors.blue.withOpacity(.4),
                        ),
                        child: const Text(
                          "Create Account",
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    /// Divider OR
                    Row(
                      children: const [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 12),
                          child: Text(
                            "OR",
                            style: TextStyle(fontSize: 22, color: Colors.grey),
                          ),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),

                    const SizedBox(height: 28),

                    /// Google Button
                    Container(
                      height: 58,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey.shade300),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            "G",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                            ),
                          ),
                          SizedBox(width: 12),
                          Text(
                            "Sign up with Google",
                            style: TextStyle(fontSize: 18),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: RichText(
                        text: const TextSpan(
                          style: TextStyle(fontSize: 18, color: Colors.black87),
                          children: [
                            TextSpan(text: "Already have an account? "),
                            TextSpan(
                              text: "Log In",
                              style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 28),

                    const Center(
                      child: Text(
                        "© 2024 RENTAL BUDDY KATHMANDU • PRIVACY\nPOLICY • TERMS",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey,
                          letterSpacing: 1,
                          height: 1.6,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8, top: 18),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          letterSpacing: 1.4,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget buildTextField({
    required String hint,
    required IconData icon,
    bool obscure = false,
  }) {
    return TextField(
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        filled: true,
        fillColor: const Color(0xFFF8F9FB),
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: const BorderSide(color: Colors.blue),
        ),
      ),
    );
  }
}
