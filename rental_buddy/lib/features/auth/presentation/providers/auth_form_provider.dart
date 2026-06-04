import 'package:flutter_riverpod/flutter_riverpod.dart';

class RegFormState {
  final String name;
  final String email;
  final String phone;
  final String password;
  final String confirmPassword;
  final bool obscurePass;
  final bool obscureConfirm;

  const RegFormState({
    this.name = '',
    this.email = '',
    this.phone = '',
    this.password = '',
    this.confirmPassword = '',
    this.obscurePass = true,
    this.obscureConfirm = true,
  });

  RegFormState copyWith({
    String? name,
    String? email,
    String? phone,
    String? password,
    String? confirmPassword,
    bool? obscurePass,
    bool? obscureConfirm,
  }) {
    return RegFormState(
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

class RegFormNotifier extends StateNotifier<RegFormState> {
  RegFormNotifier() : super(const RegFormState());

  void setName(String v) => state = state.copyWith(name: v);
  void setEmail(String v) => state = state.copyWith(email: v);
  void setPhone(String v) => state = state.copyWith(phone: v);
  void setPassword(String v) => state = state.copyWith(password: v);
  void setConfirm(String v) =>
      state = state.copyWith(confirmPassword: v);

  void togglePass() =>
      state = state.copyWith(obscurePass: !state.obscurePass);

  void toggleConfirm() =>
      state = state.copyWith(obscureConfirm: !state.obscureConfirm);
}

final regFormProvider =
    StateNotifierProvider<RegFormNotifier, RegFormState>(
  (ref) => RegFormNotifier(),
);