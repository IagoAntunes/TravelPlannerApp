import 'dart:io';

import 'package:flutter/material.dart';
import 'package:travelplannerapp/core/binding/app_binding.dart';
import 'package:travelplannerapp/core/theme/app_theme.dart';

import 'src/features/auth/presenter/bindings/auth_binding.dart';
import 'src/features/auth/presenter/pages/login_page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  AppBindings.setupBindings();
  AuthBindings.setupAuthBindings();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme.getTheme(context),
      home: LoginPage(),
    );
  }
}

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}
