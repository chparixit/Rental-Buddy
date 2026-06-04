import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rental_buddy/features/auth/data/models/user_model.dart';
import 'app.dart';

import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox<UserModel>('users');
  await Hive.openBox('session');

  runApp(const ProviderScope(child: MyApp()));
}
