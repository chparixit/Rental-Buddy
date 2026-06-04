import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'login_screen.dart';

// ---------- State ----------

class RegisterFormState {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool obscurePass;
  final bool obscureConfirm;

  const RegisterFormState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscurePass = true,
    this.obscureConfirm = true,
  });

  RegisterFormState copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? obscurePass,
    bool? obscureConfirm,
  }) {
    return RegisterFormState(
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      obscurePass: obscurePass ?? this.obscurePass,
      obscureConfirm: obscureConfirm ?? this.obscureConfirm,
    );
  }
}

class RegisterFormNotifier extends StateNotifier<RegisterFormState> {
  RegisterFormNotifier() : super(const RegisterFormState());

  void setName(String v) => state = state.copyWith(name: v);
  void setEmail(String v) => state = state.copyWith(email: v);
  void setPhone(String v) => state = state.copyWith(phone: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void setConfirmPassword(String v) => state = state.copyWith(confirmPassword: v);
  void toggleObscurePass() =>
      state = state.copyWith(obscurePass: !state.obscurePass);
  void toggleObscureConfirm() =>
      state = state.copyWith(obscureConfirm: !state.obscureConfirm);
}

final registerFormProvider =
    StateNotifierProvider.autoDispose<RegisterFormNotifier, RegisterFormState>(
  (ref) => RegisterFormNotifier(),
);

// ---------- Screen ----------

class RegisterScreen extends ConsumerWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formKey = GlobalKey<FormState>();
    final formState = ref.watch(registerFormProvider);
    final notifier = ref.read(registerFormProvider.notifier);

    void submit() {
      if (formKey.currentState!.validate()) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const LoginScreen()),
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        automaticallyImplyLeading: false,
        titleSpacing: 20,
        title: const Row(
          children: [
            Icon(Icons.location_on, color: Color(0xFF1A5CBA), size: 20),
            SizedBox(width: 6),
            Text(
              'Rental Buddy',
              style: TextStyle(
                color: Color(0xFF1A5CBA),
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
            ),
            child: const Text(
              'Login',
              style: TextStyle(
                color: Color(0xFF1A5CBA),
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.06),
                blurRadius: 20,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          padding: const EdgeInsets.all(24),
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF0D1B2A),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'Register to start your property journey in the capital.',
                  style: TextStyle(fontSize: 14, color: Color(0xFF6B7A8D)),
                ),
                const SizedBox(height: 28),

                _label('FULL NAME'),
                _inputField(
                  hint: 'Full Name',
                  icon: Icons.person_outline,
                  onChanged: notifier.setName,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter your name' : null,
                ),
                const SizedBox(height: 18),

                _label('EMAIL'),
                _inputField(
                  hint: 'Email Address',
                  icon: Icons.mail_outline,
                  keyboardType: TextInputType.emailAddress,
                  onChanged: notifier.setEmail,
                  validator: (v) => v == null || !v.contains('@')
                      ? 'Enter valid email'
                      : null,
                ),
                const SizedBox(height: 18),

                _label('PHONE'),
                _inputField(
                  hint: 'Phone Number',
                  icon: Icons.phone_outlined,
                  keyboardType: TextInputType.phone,
                  onChanged: notifier.setPhone,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Enter phone number' : null,
                ),
                const SizedBox(height: 18),

                _label('PASSWORD'),
                _passwordField(
                  hint: 'Password',
                  icon: Icons.lock_outline,
                  obscure: formState.obscurePass,
                  onChanged: notifier.setPassword,
                  onToggle: notifier.toggleObscurePass,
                  validator: (v) =>
                      v == null || v.length < 6 ? 'Min 6 characters' : null,
                ),
                const SizedBox(height: 18),

                _label('CONFIRM PASSWORD'),
                _passwordField(
                  hint: 'Confirm Password',
                  icon: Icons.lock_reset_outlined,
                  obscure: formState.obscureConfirm,
                  onChanged: notifier.setConfirmPassword,
                  onToggle: notifier.toggleObscureConfirm,
                  validator: (v) => v != formState.password
                      ? 'Passwords do not match'
                      : null,
                ),
                const SizedBox(height: 28),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: submit,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF1A5CBA),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Create Account',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 18),

                const Center(
                  child: Text(
                    'OR',
                    style: TextStyle(color: Color(0xFFAEB8C8), fontSize: 13),
                  ),
                ),
                const SizedBox(height: 14),

                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: OutlinedButton.icon(
                    onPressed: () {},
                    icon: const Text(
                      'G',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF4285F4),
                      ),
                    ),
                    label: const Text(
                      'Sign up with Google',
                      style: TextStyle(
                        fontSize: 15,
                        color: Color(0xFF0D1B2A),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFFE2E8F0)),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 22),

                Center(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Already have an account? ',
                        style: TextStyle(color: Color(0xFF6B7A8D)),
                      ),
                      GestureDetector(
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        ),
                        child: const Text(
                          'Log In',
                          style: TextStyle(
                            color: Color(0xFF1A5CBA),
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                const Center(
                  child: Text(
                    '© 2024 RENTAL BUDDY KATHMANDU • PRIVACY POLICY • TERMS',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 10,
                      color: Color(0xFFAEB8C8),
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 7),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 11,
          fontWeight: FontWeight.w700,
          color: Color(0xFF6B7A8D),
          letterSpacing: 1.2,
        ),
      ),
    );
  }

  Widget _inputField({
    required String hint,
    required IconData icon,
    required ValueChanged<String> onChanged,
    TextInputType? keyboardType,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      keyboardType: keyboardType,
      onChanged: onChanged,
      validator: validator,
      decoration: _inputDecoration(hint: hint, icon: icon),
    );
  }

  Widget _passwordField({
    required String hint,
    required IconData icon,
    required bool obscure,
    required ValueChanged<String> onChanged,
    required VoidCallback onToggle,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      obscureText: obscure,
      onChanged: onChanged,
      validator: validator,
      decoration: _inputDecoration(
        hint: hint,
        icon: icon,
        suffix: IconButton(
          icon: Icon(
            obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
            color: const Color(0xFFAEB8C8),
            size: 20,
          ),
          onPressed: onToggle,
        ),
      ),
    );
  }

  InputDecoration _inputDecoration({
    required String hint,
    required IconData icon,
    Widget? suffix,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Color(0xFFAEB8C8)),
      prefixIcon: Icon(icon, color: const Color(0xFFAEB8C8), size: 20),
      suffixIcon: suffix,
      filled: true,
      fillColor: const Color(0xFFF8FAFC),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE2E8F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF1A5CBA), width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }
}