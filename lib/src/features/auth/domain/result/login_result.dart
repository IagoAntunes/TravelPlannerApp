import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/src/features/auth/domain/models/user_model.dart';

class LoginResult extends IBaseResult {
  LoginResult.success({
    super.isSuccess = true,
    required super.statusCode,
    required super.statusMsg,
    required this.token,
    required this.user,
  });
  LoginResult.failure({
    super.isSuccess = false,
    required super.statusCode,
    required super.statusMsg,
    this.token,
    this.user,
  });
  final UserModel? user;
  final String? token;
}
