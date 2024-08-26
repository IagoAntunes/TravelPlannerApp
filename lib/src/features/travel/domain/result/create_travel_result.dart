import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';

class CreateTravelResult extends IBaseResult {
  CreateTravelResult.success({
    super.isSuccess = true,
    required super.statusCode,
    required super.statusMsg,
    required this.travel,
  });
  CreateTravelResult.failure({
    super.isSuccess = false,
    required super.statusCode,
    required super.statusMsg,
    this.travel,
  });
  TravelModel? travel;
}
