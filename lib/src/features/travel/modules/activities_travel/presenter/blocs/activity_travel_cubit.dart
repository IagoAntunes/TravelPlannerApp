import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_travel_repository.dart';
import 'package:travelplannerapp/src/features/travel/modules/activities_travel/presenter/states/activity_travel_state.dart';

import '../../../../domain/model/activity_model.dart';

enum EnumActivityTravelType {
  activities,
  details,
}

class ActivityTravelCubit extends Cubit<IActivityTravelState> {
  ActivityTravelCubit({required ITravelsRepository travelRepository})
      : _travelRepository = travelRepository,
        super(IdleActivityTravelState(type: EnumActivityTravelType.activities));

  final ITravelsRepository _travelRepository;

  Map<String, List<ActivityModel>> groupedActivities = {};

  void fetchActivities(int travelId) async {
    emit(LoadingActivityTravelState(type: state.type));
    final result = await _travelRepository.fetchActivities(travelId);
    for (var activity in result.activities) {
      if (groupedActivities.containsKey(activity.date)) {
        groupedActivities[activity.date]!.add(activity);
      } else {
        groupedActivities[activity.date.split(' ')[0]] = [activity];
      }
    }
    if (result.isSuccess) {
      emit(SuccessActivityTravelState(
        groupedActivities: groupedActivities,
        type: state.type,
      ));
    } else {
      emit(FailureActivityTravelState(type: state.type));
    }
  }

  void changeActivityTravelType(EnumActivityTravelType type) {
    if (state is SuccessActivityTravelState) {
      state.type = type;
      emit(SuccessActivityTravelState(
        groupedActivities:
            (state as SuccessActivityTravelState).groupedActivities,
        type: type,
      ));
    } else {
      emit(IdleActivityTravelState(type: type));
    }
  }
}
