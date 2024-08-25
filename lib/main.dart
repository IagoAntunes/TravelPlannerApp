import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/core/binding/app_binding.dart';
import 'package:travelplannerapp/core/theme/app_theme.dart';
import 'package:travelplannerapp/services/database/external/sharedPreferences/shared_preferences_keys.dart';
import 'package:travelplannerapp/src/features/auth/presenter/blocs/auth_cubit.dart';
import 'package:travelplannerapp/src/features/create_travel/presenter/bindings/create_travel_binding.dart';
import 'package:travelplannerapp/src/features/home/presenter/bindings/home_binding.dart';

import 'services/database/external/sharedPreferences/shared_preferences_service.dart';
import 'src/features/auth/presenter/bindings/auth_binding.dart';
import 'src/features/auth/presenter/pages/login_page.dart';
import 'src/features/auth/presenter/states/auth_state.dart';
import 'src/features/home/presenter/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HttpOverrides.global = MyHttpOverrides();
  await AppBindings.setupBindings();
  CreateTravelBinding.setUpCreateTravelBindings();
  HomeBinding.setUpHomeBindings();
  AuthBindings.setupAuthBindings();

  final prefs = GetIt.I.get<SharedPreferencesService>();

  var isAuthenticated =
      await prefs.getData(SharedPreferencesKeys.isAuthenticated) ?? false;

  if (isAuthenticated) {
    GetIt.I.get<AuthCubit>().state.isAuthenticated = true;
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _authCubit = GetIt.I.get<AuthCubit>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TravelPlanner',
      theme: AppTheme.getTheme(context),
      home: BlocBuilder<AuthCubit, IAuthState>(
        bloc: _authCubit,
        builder: (context, state) {
          if (state.isAuthenticated) {
            return HomePage();
          }
          return LoginPage();
        },
      ),
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
