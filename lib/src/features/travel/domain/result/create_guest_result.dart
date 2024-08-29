import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/guest_model.dart';

class CreateGuestResult extends IBaseResult {
  CreateGuestResult.success({
    required this.guest,
    super.isSuccess = true,
    required super.statusCode,
    required super.statusMsg,
  });
  CreateGuestResult.failure({
    this.guest,
    super.isSuccess = false,
    required super.statusCode,
    required super.statusMsg,
  });
  final GuestModel? guest;
}
