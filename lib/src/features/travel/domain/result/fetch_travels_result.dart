import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';

class FetchTravelsResult extends IBaseResult {
  FetchTravelsResult.success({
    required this.travels,
    required super.statusCode,
    required super.statusMsg,
    super.isSuccess = true,
  });

  FetchTravelsResult.failure({
    this.travels = const [],
    required super.statusCode,
    required super.statusMsg,
    super.isSuccess = false,
  });
  List<TravelModel> travels;
}
