import 'dart:convert';
import 'package:crypto/crypto.dart';
import 'package:hive/hive.dart';
import '../models/user_model.dart';

class AuthLocalDatasource {
  Box<UserModel> get _userBox => Hive.box<UserModel>('users');
  Box get _sessionBox => Hive.box('session');

  String _hashPassword(String password) {
    final bytes = utf8.encode(password);
    return sha256.convert(bytes).toString();
  }

  Future<UserModel> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    // Check if email already exists
    final exists = _userBox.values.any(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
    );
    if (exists) throw Exception('Email already registered');

    final user = UserModel(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      name: name,
      email: email,
      phone: phone,
      hashedPassword: _hashPassword(password),
    );

    await _userBox.put(user.id, user);
    await _sessionBox.put('userId', user.id);
    return user;
  }

  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final user = _userBox.values.firstWhere(
      (u) => u.email.toLowerCase() == email.toLowerCase(),
      orElse: () => throw Exception('No account found with this email'),
    );

    if (user.hashedPassword != _hashPassword(password)) {
      throw Exception('Incorrect password');
    }

    await _sessionBox.put('userId', user.id);
    return user;
  }

  Future<void> logout() async {
    await _sessionBox.delete('userId');
  }

  UserModel? getSessionUser() {
    final userId = _sessionBox.get('userId');
    if (userId == null) return null;
    return _userBox.get(userId);
  }
}