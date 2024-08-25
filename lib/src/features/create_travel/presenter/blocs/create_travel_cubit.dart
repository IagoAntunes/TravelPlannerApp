import 'package:bloc/bloc.dart';
import 'package:travelplannerapp/src/features/create_travel/presenter/states/create_travel_state.dart';

enum CreateTravelStep {
  initial,
  guests,
}

class CreateTravelCubit extends Cubit<ICreateTravelState> {
  CreateTravelCubit()
      : super(
          IdleCreateTravelState(
            createTravelStep: CreateTravelStep.initial,
          ),
        );

  List<String> emailGuests = [];

  void changeStepToGuests() {
    emit(IdleCreateTravelState(createTravelStep: CreateTravelStep.guests));
  }

  void changeStepToInitial() {
    emit(IdleCreateTravelState(createTravelStep: CreateTravelStep.initial));
  }
}
