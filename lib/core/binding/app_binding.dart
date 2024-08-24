import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/services/http/domain/http_service.dart';
import 'package:travelplannerapp/services/http/infra/http_service_imp.dart';
import 'package:travelplannerapp/services/storage/domain/secure_storage.dart';
import 'package:travelplannerapp/services/storage/infra/secure_storage_imp.dart';

class AppBindings {
  static Future<void> setupBindings() async {
    var getIt = GetIt.instance;
    var dio = Dio();
    dio.options.validateStatus = (status) {
      return true;
    };
    getIt.registerSingleton<Dio>(dio);

    getIt.registerSingleton<ISecureStorage>(
      SecureStorage(),
    );
    getIt.registerSingleton<IHttpService>(
      HttpServiceImp(),
    );
  }
}
