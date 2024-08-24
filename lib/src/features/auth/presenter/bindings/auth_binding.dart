import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/auth/domain/repository/i_auth_repository.dart';
import 'package:travelplannerapp/src/features/auth/external/datasource/auth_datasource.dart';
import 'package:travelplannerapp/src/features/auth/infra/datasource/i_auth_datasource.dart';
import 'package:travelplannerapp/src/features/auth/infra/repository/auth_repository.dart';
import 'package:travelplannerapp/src/features/auth/presenter/blocs/login_cubit.dart';
import 'package:travelplannerapp/src/features/auth/presenter/blocs/register_cubit.dart';

class AuthBindings {
  static void setupAuthBindings() {
    var getIt = GetIt.instance;

    getIt.registerFactory<IAuthDataSource>(
      () => AuthDataSource(
        httpService: getIt(),
      ),
    );

    getIt.registerFactory<IAuthRepository>(
      () => AuthRepository(
        dataSource: getIt(),
        secureStorage: getIt(),
      ),
    );

    getIt.registerFactory(
      () => LoginCubit(repository: getIt()),
    );

    getIt.registerFactory(
      () => RegisterCubit(authRepository: getIt()),
    );
  }
}
