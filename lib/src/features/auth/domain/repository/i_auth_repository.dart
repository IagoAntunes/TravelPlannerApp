import '../result/login_result.dart';

abstract class IAuthRepository {
  Future<LoginResult> login(String email, String password);
}
