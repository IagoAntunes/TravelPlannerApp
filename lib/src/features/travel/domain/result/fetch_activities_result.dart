import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/activity_model.dart';

class FetchActivitiesResult extends IBaseResult {
  FetchActivitiesResult.success({
    super.isSuccess = true,
    required super.statusCode,
    required super.statusMsg,
    required this.activities,
  });
  FetchActivitiesResult.failure({
    super.isSuccess = false,
    required super.statusCode,
    required super.statusMsg,
    this.activities = const [],
  });

  List<ActivityModel> activities;
}
