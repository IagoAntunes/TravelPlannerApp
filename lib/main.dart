import 'package:flutter/material.dart';
import 'package:travelplannerapp/core/theme/app_theme.dart';

import 'src/features/auth/presenter/pages/login_page.dart';

void main() {
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
