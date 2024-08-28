import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
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

  List<ActivityModel> get activities {
    List<ActivityModel> activities = [];
    for (var activitiesList in groupedActivities.values) {
      activities.addAll(activitiesList);
    }
    return activities;
  }

  Future<bool> deleteTravel(int travelId) async {
    var result = await _travelRepository.deleteTravel(travelId);
    if (result.isSuccess) {
      return true;
    } else {
      return false;
    }
  }

  void fetchActivities(int travelId) async {
    groupedActivities.clear();
    emit(LoadingActivityTravelState(type: state.type));
    final result = await _travelRepository.fetchActivities(travelId);
    for (var activity in result.activities) {
      if (groupedActivities.containsKey(activity.date.split(' ')[0])) {
        groupedActivities[activity.date.split(' ')[0]]!.add(activity);
      } else {
        groupedActivities[activity.date.split(' ')[0]] = [activity];
      }
    }
    for (var activities in groupedActivities.values) {
      activities.sort((a, b) => a.date.compareTo(b.date));
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

  Future<void> createActivity(
      String name, String date, String time, int travelId) async {
    emit(LoadingActivityTravelState(type: state.type));

    List<String> dateParts = date.split('/');
    int day = int.parse(dateParts[0]);
    int month = int.parse(dateParts[1]);
    int year = int.parse(dateParts[2]);

    List<String> timeParts = time.split(':');
    int hour = int.parse(timeParts[0]);
    int minute = int.parse(timeParts[1]);

    DateTime dateTime = DateTime(year, month, day, hour, minute);
    String formattedDate = DateFormat('dd/MM/yyyy HH:mm').format(dateTime);
    var result = await _travelRepository.createActivity(
      name,
      formattedDate,
      travelId,
    );
    if (result.isSuccess) {
      emit(CreatedActivityTravelListener(type: state.type));
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

  void deleteActivity(int activityId) async {
    //emit(LoadingActivityTravelState(type: state.type));
    state as SuccessActivityTravelState;
    groupedActivities.forEach((key, value) {
      value.removeWhere((element) => element.id == activityId);
    });
    final result = await _travelRepository.deleteActivity(activityId);
    if (result.isSuccess) {
      emit(SuccessActivityTravelState(
        type: state.type,
        groupedActivities: groupedActivities,
      ));
    } else {
      emit(FailureActivityTravelState(type: state.type));
    }
  }
}
