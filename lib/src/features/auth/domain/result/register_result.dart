import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/src/features/auth/domain/models/user_model.dart';

class RegisterResult extends IBaseResult {
  RegisterResult.success({
    super.isSuccess = true,
    required super.statusCode,
    required super.statusMsg,
    required this.user,
  });

  RegisterResult.failure({
    super.isSuccess = false,
    required super.statusCode,
    required super.statusMsg,
    this.user,
  });

  final UserModel? user;
}
