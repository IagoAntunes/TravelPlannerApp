import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';

abstract class IListTravelsState {}

class IdleListTravelsState extends IListTravelsState {}

class LoadingListTravelsState extends IListTravelsState {}

class SuccessListTravelsState extends IListTravelsState {
  SuccessListTravelsState({
    required this.travels,
  });
  List<TravelModel> travels;
}

class FailureListTravelsState extends IListTravelsState {}
