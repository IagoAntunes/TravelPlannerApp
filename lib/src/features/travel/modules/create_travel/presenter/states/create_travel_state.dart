import '../blocs/create_travel_cubit.dart';

abstract class ICreateTravelState {
  ICreateTravelState({required this.createTravelStep});
  CreateTravelStep createTravelStep;
}

class IdleCreateTravelState extends ICreateTravelState {
  IdleCreateTravelState({required super.createTravelStep});
}
