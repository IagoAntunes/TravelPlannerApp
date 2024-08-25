import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelplannerapp/services/http/domain/http_service.dart';
import 'package:travelplannerapp/services/http/infra/http_service_imp.dart';
import 'package:travelplannerapp/services/storage/domain/secure_storage.dart';
import 'package:travelplannerapp/services/storage/infra/secure_storage_imp.dart';
import 'package:travelplannerapp/src/features/auth/presenter/blocs/auth_cubit.dart';

import '../../services/database/external/sharedPreferences/shared_preferences_service.dart';

class AppBindings {
  static Future<void> setupBindings() async {
    var getIt = GetIt.instance;
    var dio = Dio();
    dio.options.validateStatus = (status) {
      return true;
    };

    var prefs = await SharedPreferences.getInstance();

    getIt.registerFactory<SharedPreferences>(
      () => prefs,
    );
    getIt.registerSingleton<SharedPreferencesService>(
      SharedPreferencesService(
        preferences: getIt(),
      ),
    );
    getIt.registerSingleton<Dio>(dio);

    getIt.registerSingleton<ISecureStorage>(
      SecureStorage(),
    );
    getIt.registerSingleton<IHttpService>(
      HttpServiceImp(),
    );

    getIt.registerSingleton(AuthCubit(
      service: getIt(),
    ));
  }
}
