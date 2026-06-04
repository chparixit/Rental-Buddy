import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_buddy/features/auth/presentation/providers/auth_state.dart';
import '../providers/auth_form_provider.dart';

import '../providers/auth_provider.dart';
import '../widgets/auth_input_field.dart';
import '../../../../features/dashboard/home_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final form = ref.watch(regFormProvider);
    final formNotifier = ref.read(regFormProvider.notifier);

    final authState = ref.watch(authProvider);
    final authNotifier = ref.read(authProvider.notifier);

    ref.listen<AuthState>(authProvider, (_, next) {
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

    return Scaffold(
      backgroundColor: const Color(0xFFF0F4FA),
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).unfocus(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Container(
              padding: const EdgeInsets.all(24),
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

                    const SizedBox(height: 30),

                    AuthInputField(
                      hint: 'Full Name',
                      icon: Icons.person_outline,
                      onChanged: formNotifier.setName,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter name' : null,
                    ),

                    const SizedBox(height: 15),

                    AuthInputField(
                      hint: 'Email',
                      icon: Icons.email_outlined,
                      keyboardType: TextInputType.emailAddress,
                      onChanged: formNotifier.setEmail,
                      validator: (v) => v == null || !v.contains('@')
                          ? 'Enter valid email'
                          : null,
                    ),

                    const SizedBox(height: 15),

                    AuthInputField(
                      hint: 'Phone',
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                      onChanged: formNotifier.setPhone,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Enter phone' : null,
                    ),

                    const SizedBox(height: 15),

                    AuthInputField(
                      hint: 'Password',
                      icon: Icons.lock,
                      obscure: form.obscurePass,
                      onChanged: formNotifier.setPassword,
                      suffix: IconButton(
                        icon: Icon(
                          form.obscurePass
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: formNotifier.togglePass,
                      ),
                      validator: (v) =>
                          v == null || v.length < 6 ? 'Min 6 chars' : null,
                    ),

                    const SizedBox(height: 15),

                    AuthInputField(
                      hint: 'Confirm Password',
                      icon: Icons.lock_outline,
                      obscure: form.obscureConfirm,
                      onChanged: formNotifier.setConfirm,
                      suffix: IconButton(
                        icon: Icon(
                          form.obscureConfirm
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: formNotifier.toggleConfirm,
                      ),
                      validator: (v) =>
                          v != form.password ? 'Password mismatch' : null,
                    ),

                    const SizedBox(height: 25),

                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: authState is AuthLoading
                            ? null
                            : () {
                                if (formKey.currentState!.validate()) {
                                  authNotifier.register(
                                    name: form.name,
                                    email: form.email,
                                    phone: form.phone,
                                    password: form.password,
                                  );
                                }
                              },
                        child: authState is AuthLoading
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            : const Text("Create Account"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
