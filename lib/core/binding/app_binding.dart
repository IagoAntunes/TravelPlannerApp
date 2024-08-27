import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelplannerapp/services/http/domain/http_service.dart';
import 'package:travelplannerapp/services/http/infra/authentication_interceptor.dart';
import 'package:travelplannerapp/services/http/infra/error_api_interceptor.dart';
import 'package:travelplannerapp/services/http/infra/http_service_imp.dart';
import 'package:travelplannerapp/services/storage/domain/secure_storage.dart';
import 'package:travelplannerapp/services/storage/infra/secure_storage_imp.dart';
import 'package:travelplannerapp/src/features/auth/presenter/blocs/auth_cubit.dart';

import '../../services/database/external/sharedPreferences/shared_preferences_service.dart';

class AppBindings {
  static Future<void> setupBindings() async {
    var getIt = GetIt.instance;

    getIt.registerSingleton<ISecureStorage>(
      SecureStorage(),
    );

    var prefs = await SharedPreferences.getInstance();

    getIt.registerFactory<SharedPreferences>(
      () => prefs,
    );
    getIt.registerSingleton<SharedPreferencesService>(
      SharedPreferencesService(
        preferences: getIt(),
      ),
    );

    var dio = Dio();

    getIt.registerSingleton<Dio>(dio);
    dio.interceptors.add(AuthenticationInterceptor(secureStorage: getIt()));
    dio.interceptors.add(AuthInterceptor(
      dio: getIt(),
      secureStorage: getIt(),
    ));
    getIt.registerSingleton<IHttpService>(
      HttpServiceImp(),
    );

    getIt.registerSingleton(AuthCubit(
      service: getIt(),
    ));
  }
}
