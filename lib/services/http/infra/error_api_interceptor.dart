import 'package:dio/dio.dart';
import 'package:travelplannerapp/core/utils/app_routes_api.dart';
import 'package:travelplannerapp/core/utils/secure_storage_keys.dart';
import 'package:travelplannerapp/services/storage/domain/secure_storage.dart';

class AuthInterceptor extends Interceptor {
  AuthInterceptor({required Dio dio, required ISecureStorage secureStorage})
      : _secureStorage = secureStorage,
        _dio = dio;
  final Dio _dio;
  final ISecureStorage _secureStorage;

  @override
  Future<void> onError(
      DioException err, ErrorInterceptorHandler handler) async {
    // Verifica se o erro é um 403 e se a mensagem de erro indica que o token expirou
    if (err.response?.realUri.path.contains('refreshToken') ?? false) {
      return handler.reject(err);
    }
    if (err.response?.statusCode == 403) {
      // Verifica se já tentamos o refresh do token para esta requisição
      if (err.requestOptions.headers['isRetry'] == true) {
        return handler.reject(err);
      }

      // Tenta o refresh do token
      try {
        var token = await _secureStorage.readData(key: SecureStorageKeys.token);
        if (token == null || token.isEmpty) {
          return handler.reject(err);
        }
        final refreshTokenResponse = await _dio.post(
          AppRoutesApi.refreshToken,
          data: {
            'token': token,
          },
        );

        if (refreshTokenResponse.statusCode == 200) {
          final newAccessToken = refreshTokenResponse.data['token'];

          // Atualiza o header de Authorization com o novo token
          err.requestOptions.headers['Authorization'] =
              'Bearer $newAccessToken';
          // Marca a requisição como retry
          err.requestOptions.headers['isRetry'] = true;

          // Reenvia a requisição original com o novo token
          final opts = Options(
            method: err.requestOptions.method,
            headers: err.requestOptions.headers,
          );
          final cloneReq = await _dio.request(
            err.requestOptions.path,
            options: opts,
            data: err.requestOptions.data,
            queryParameters: err.requestOptions.queryParameters,
          );
          await _secureStorage.writeData(
              key: SecureStorageKeys.token, value: newAccessToken);
          return handler.resolve(cloneReq);
        } else {
          // Se o refresh falhar, propaga o erro
          return handler.reject(err);
        }
      } catch (e) {
        // Se der erro na tentativa de refresh, propaga o erro original
        return handler.reject(err);
      }
    } else {
      // Se não for 403 ou não for um erro de token expirado, propaga o erro normalmente
      return handler.reject(err);
    }
  }

  // bool _isTokenExpiredError(DioException err) {
  //   // Verifique a mensagem de erro ou código de erro específico para determinar se o token expirou
  //   // Isso depende de como sua API indica um token expirado
  //   // Exemplo:
  //   return err.response?.data['message'] == 'Token expired';
  // }
}
