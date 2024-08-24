import 'package:dio/dio.dart';
import 'package:travelplannerapp/services/storage/infra/secure_storage_imp.dart';

import '../../../core/utils/secure_storage_keys.dart';
import 'http_exceptions_imp.dart';

class AuthenticationInterceptor extends Interceptor {
  AuthenticationInterceptor({required SecureStorage secureStorage})
      : _secureStorage = secureStorage;
  final SecureStorage _secureStorage;
  @override
  void onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    var token = await _secureStorage.readData(key: SecureStorageKeys.token);
    if (!options.headers.containsKey('Authorization')) {
      options.headers.addAll({"Authorization": "Bearer $token"});
    }
    return super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    if (response.data is Map<String, dynamic>) {
      if ((response.data as Map<String, dynamic>).containsKey('Message')) {
        if (response.data['Message'] ==
            "Authorization has been denied for this request.") {
          throw AuthenticationException();
        }
      }
    }
  }
}
