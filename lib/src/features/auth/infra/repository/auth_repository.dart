import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/core/utils/secure_storage_keys.dart';
import 'package:travelplannerapp/services/database/external/sharedPreferences/shared_preferences_service.dart';
import 'package:travelplannerapp/services/storage/domain/secure_storage.dart';
import 'package:travelplannerapp/src/features/auth/domain/models/user_model.dart';
import 'package:travelplannerapp/src/features/auth/domain/repository/i_auth_repository.dart';
import 'package:travelplannerapp/src/features/auth/domain/request/register_user_request.dart';
import 'package:travelplannerapp/src/features/auth/domain/result/register_result.dart';
import 'package:travelplannerapp/src/features/auth/infra/datasource/i_auth_datasource.dart';

import '../../../../../services/database/external/sharedPreferences/shared_preferences_keys.dart';
import '../../domain/request/login_request.dart';
import '../../domain/result/login_result.dart';

class AuthRepository extends IAuthRepository {
  AuthRepository({
    required IAuthDataSource dataSource,
    required ISecureStorage secureStorage,
    required SharedPreferencesService sharedPreferences,
  })  : _dataSource = dataSource,
        _secureStorage = secureStorage,
        _sharedPreferences = sharedPreferences;
  final IAuthDataSource _dataSource;
  final ISecureStorage _secureStorage;
  final SharedPreferencesService _sharedPreferences;

  @override
  Future<LoginResult> login(String email, String password) async {
    final request = LoginRequest(
      email: email,
      password: password,
    );
    final result = await _dataSource.login(request);
    if (result is SuccessResponseData) {
      var token = result.data['token'];
      var user = UserModel.fromMap(result.data['user']);

      await _secureStorage.writeData(
        key: SecureStorageKeys.token,
        value: token,
      );

      _sharedPreferences.saveData(SharedPreferencesKeys.isAuthenticated, true);
      return LoginResult.success(
        statusCode: result.statusCode,
        statusMsg: result.statusMsg,
        token: token,
        user: user,
      );
    } else {
      result as ErrorResponseData;
      return LoginResult.failure(
        statusCode: result.errorCode,
        statusMsg: result.errorMessage,
      );
    }
  }

  @override
  Future<RegisterResult> register(
      String username, String email, String password) async {
    var request = RegisterUserRequest(
      username: username,
      email: email,
      password: password,
    );

    var response = await _dataSource.register(request);
    if (response is SuccessResponseData) {
      var user = UserModel.fromMap(response.data['user']);

      var result = RegisterResult.success(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
        user: user,
      );

      return result;
    } else {
      response as ErrorResponseData;

      return RegisterResult.failure(
        statusCode: response.errorCode,
        statusMsg: response.errorMessage,
      );
    }
  }
}
