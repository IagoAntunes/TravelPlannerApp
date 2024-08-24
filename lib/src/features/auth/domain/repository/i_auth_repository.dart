import 'package:travelplannerapp/src/features/auth/domain/result/register_result.dart';

import '../result/login_result.dart';

abstract class IAuthRepository {
  Future<LoginResult> login(String email, String password);
  Future<RegisterResult> register(
      String username, String email, String password);
}
