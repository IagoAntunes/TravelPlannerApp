import 'package:travelplannerapp/core/utils/base_repository_result.dart';

class CreateActivityResult extends IBaseResult {
  CreateActivityResult.success({
    super.isSuccess = true,
    required super.statusCode,
    required super.statusMsg,
  });
  CreateActivityResult.failure({
    super.isSuccess = false,
    required super.statusCode,
    required super.statusMsg,
  });
}
