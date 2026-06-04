import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_buddy/features/auth/data/datasources/auth_local_datasource.dart';

import 'auth_state.dart';

final authProvider =
    StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(AuthLocalDatasource());
});

class AuthNotifier extends StateNotifier<AuthState> {
  final AuthLocalDatasource _datasource;

  AuthNotifier(this._datasource) : super(AuthInitial());

  Future<void> login({
  required String email,
  required String password,
}) async {
  state = AuthLoading();

  try {
    final user = await _datasource.login(
      email: email,
      password: password,
    );

    state = AuthSuccess(user);
  } catch (e) {
    state = AuthError(e.toString());
  }
}

  Future<void> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    state = AuthLoading();

    try {
      final user = await _datasource.register(
        name: name,
        email: email,
        phone: phone,
        password: password,
      );

      state = AuthSuccess(user);
    } catch (e) {
      state = AuthError(e.toString());
    }
  }
}