import 'package:flutter/material.dart';
import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  /// Future setup here
  /// await Firebase.initializeApp();
  /// await SharedPreferences.getInstance();

  runApp(const MyApp());
}