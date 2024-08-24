import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/core/utils/secure_storage_keys.dart';
import 'package:travelplannerapp/services/storage/domain/secure_storage.dart';
import 'package:travelplannerapp/src/features/auth/domain/models/user_model.dart';
import 'package:travelplannerapp/src/features/auth/domain/repository/i_auth_repository.dart';
import 'package:travelplannerapp/src/features/auth/infra/datasource/i_auth_datasource.dart';

import '../../domain/request/login_request.dart';
import '../../domain/result/login_result.dart';

class AuthRepository extends IAuthRepository {
  AuthRepository({
    required IAuthDataSource dataSource,
    required ISecureStorage secureStorage,
  })  : _dataSource = dataSource,
        _secureStorage = secureStorage;
  final IAuthDataSource _dataSource;
  final ISecureStorage _secureStorage;

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
          key: SecureStorageKeys.token, value: token);

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
}
