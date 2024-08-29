import '../../../../domain/model/activity_model.dart';

abstract class IActivityTravelState {}

abstract class IActivityTravelListener extends IActivityTravelState {}

class CreatedActivityTravelListener extends IActivityTravelListener {}

class IdleActivityTravelState extends IActivityTravelState {}

class LoadingActivityTravelState extends IActivityTravelState {}

class SuccessActivityTravelState extends IActivityTravelState {
  SuccessActivityTravelState({required this.groupedActivities});
  final Map<String, List<ActivityModel>> groupedActivities;
}

class FailureActivityTravelState extends IActivityTravelState {
  FailureActivityTravelState();
}
