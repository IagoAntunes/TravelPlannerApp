import '../blocs/create_travel_cubit.dart';

abstract class ICreateTravelState {
  ICreateTravelState({required this.createTravelStep});
  CreateTravelStep createTravelStep;
}

abstract class ICreateTravelListener extends ICreateTravelState {
  ICreateTravelListener({required super.createTravelStep});
}

class IdleCreateTravelState extends ICreateTravelState {
  IdleCreateTravelState({required super.createTravelStep});
}

class LoadingCreateTravelState extends ICreateTravelState {
  LoadingCreateTravelState({required super.createTravelStep});
}

class CreatedTravelListener extends ICreateTravelListener {
  CreatedTravelListener({
    required super.createTravelStep,
  });
}

class FailureCreateTravelListener extends ICreateTravelListener {
  FailureCreateTravelListener({
    required super.createTravelStep,
    required this.message,
  });
  String message;
}
