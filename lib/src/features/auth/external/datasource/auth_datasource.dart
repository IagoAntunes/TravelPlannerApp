import 'dart:io';

import 'package:dio/dio.dart';
import 'package:travelplannerapp/core/utils/app_routes_api.dart';
import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/auth/domain/request/login_request.dart';
import 'package:travelplannerapp/src/features/auth/domain/request/register_user_request.dart';
import 'package:travelplannerapp/src/features/auth/infra/datasource/i_auth_datasource.dart';

class AuthDataSource implements IAuthDataSource {
  AuthDataSource({required Dio httpService}) : _httpService = httpService;
  final Dio _httpService;

  @override
  Future<IResponseData> login(LoginRequest request) async {
    try {
      final response = await _httpService.post(
        AppRoutesApi.authLogin,
        data: request.toJson(),
      );

      if (response.statusCode == HttpStatus.ok) {
        return ResponseData.success(response.data);
      } else {
        return ResponseData.error(response.data);
      }
    } catch (e) {
      return ResponseData.error({});
    }
  }

  @override
  Future<IResponseData> register(RegisterUserRequest request) async {
    try {
      final response = await _httpService.post(
        AppRoutesApi.authRegister,
        data: request.toMap(),
      );

      if (response.statusCode == HttpStatus.ok) {
        return ResponseData.success(response.data);
      } else {
        return ResponseData.error(response.data);
      }
    } catch (e) {
      return ResponseData.error({});
    }
  }
}
