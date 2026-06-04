import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_buddy/features/auth/presentation/providers/auth_state.dart';

import '../../presentation/providers/auth_provider.dart';
import '../../../../features/dashboard/home_screen.dart';
import '../widgets/auth_input_field.dart';
import 'register_screen.dart';

// ── Form state ────────────────────────────────────────────────────────────────

class _LoginFormState {
  final String email;
  final String password;
  final bool obscurePass;
  const _LoginFormState({
    this.email = '',
    this.password = '',
    this.obscurePass = true,
  });
  _LoginFormState copyWith({String? email, String? password, bool? obscurePass}) =>
      _LoginFormState(
        email: email ?? this.email,
        password: password ?? this.password,
        obscurePass: obscurePass ?? this.obscurePass,
      );
}

class _LoginFormNotifier extends StateNotifier<_LoginFormState> {
  _LoginFormNotifier() : super(const _LoginFormState());
  void setEmail(String v) => state = state.copyWith(email: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void toggleObscure() => state = state.copyWith(obscurePass: !state.obscurePass);
}

final _loginFormProvider =
    StateNotifierProvider.autoDispose<_LoginFormNotifier, _LoginFormState>(
  (_) => _LoginFormNotifier(),
);

// ── Screen ────────────────────────────────────────────────────────────────────

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();

    ref.listenManual<AuthState>(authProvider, (prev, next) {
      if (next is AuthSuccess) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (_) => HomeScreen(userName: next.user.name),
          ),
          (route) => false,
        );
      }

      if (next is AuthError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.message),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(_loginFormProvider);
    final formNotifier = ref.read(_loginFormProvider.notifier);
    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: formKey,
              child: Column(
                children: [
                  const SizedBox(height: 40),

                  const Text(
                    "Rental Buddy",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 30),

                  _label("EMAIL"),
                  AuthInputField(
                    hint: "name@example.com",
                    icon: Icons.mail_outline,
                    keyboardType: TextInputType.emailAddress,
                    onChanged: formNotifier.setEmail,
                    validator: (v) =>
                        v == null || !v.contains('@')
                            ? 'Enter valid email'
                            : null,
                  ),

                  const SizedBox(height: 18),

                  _label("PASSWORD"),
                  AuthInputField(
                    hint: "••••••••",
                    icon: Icons.lock_outline,
                    obscure: form.obscurePass,
                    onChanged: formNotifier.setPassword,
                    suffix: IconButton(
                      icon: Icon(
                        form.obscurePass
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                      onPressed: formNotifier.toggleObscure,
                    ),
                    validator: (v) =>
                        v == null || v.isEmpty
                            ? 'Enter password'
                            : null,
                  ),

                  const SizedBox(height: 25),

                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: authState is AuthLoading
                          ? null
                          : () {
                              if (formKey.currentState!.validate()) {
                                authNotifier.login(
                                  email: form.email,
                                  password: form.password,
                                );
                              }
                            },
                      child: authState is AuthLoading
                          ? const CircularProgressIndicator(
                              color: Colors.white,
                            )
                          : const Text("Login"),
                    ),
                  ),

                  const SizedBox(height: 20),

                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const RegisterScreen(),
                        ),
                      );
                    },
                    child: const Text("Create Account"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 11,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
}