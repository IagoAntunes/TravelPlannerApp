import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/auth/domain/request/register_user_request.dart';

import '../../domain/request/login_request.dart';

abstract class IAuthDataSource {
  Future<IResponseData> login(LoginRequest request);
  Future<IResponseData> register(RegisterUserRequest request);
}
