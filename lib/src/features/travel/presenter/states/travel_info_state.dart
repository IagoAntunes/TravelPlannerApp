import '../blocs/travel_info_cubit.dart';

abstract class ITravelInfoState {
  ITravelInfoState({required this.type});
  EnumActivityTravelType type;
}

abstract class ITravelInfoListener extends ITravelInfoState {
  ITravelInfoListener({required super.type});
}

class LoadingDeleteTravelInfoListener extends ITravelInfoListener {
  LoadingDeleteTravelInfoListener({required super.type});
}

class SuccessDeleteTravelInfoListener extends ITravelInfoListener {
  SuccessDeleteTravelInfoListener({required super.type});
}

class FailureDeleteTravelInfoListener extends ITravelInfoListener {
  FailureDeleteTravelInfoListener({required super.type});
}

class IdleTravelInfoState extends ITravelInfoState {
  IdleTravelInfoState({required super.type});
}
