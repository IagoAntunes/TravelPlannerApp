import '../../../../domain/model/activity_model.dart';
import '../blocs/activity_travel_cubit.dart';

abstract class IActivityTravelState {
  IActivityTravelState({required this.type});
  EnumActivityTravelType type;
}

class IdleActivityTravelState extends IActivityTravelState {
  IdleActivityTravelState({required super.type});
}

class LoadingActivityTravelState extends IActivityTravelState {
  LoadingActivityTravelState({required super.type});
}

class SuccessActivityTravelState extends IActivityTravelState {
  SuccessActivityTravelState(
      {required this.groupedActivities, required super.type});
  final Map<String, List<ActivityModel>> groupedActivities;
}

class FailureActivityTravelState extends IActivityTravelState {
  FailureActivityTravelState({required super.type});
}
