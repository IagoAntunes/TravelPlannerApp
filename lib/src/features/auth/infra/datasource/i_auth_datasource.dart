import 'package:travelplannerapp/core/utils/base_service_response.dart';

import '../../domain/request/login_request.dart';

abstract class IAuthDataSource {
  Future<IResponseData> login(LoginRequest request);
}
