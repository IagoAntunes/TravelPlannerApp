import 'package:bloc/bloc.dart';

import '../states/home_state.dart';

enum HomeModuleType {
  listTravels,
  createTravel,
}

class HomeCubit extends Cubit<IHomeState> {
  HomeCubit()
      : super(IdleHomeState(homeModuleType: HomeModuleType.listTravels));

  void changeHomeModuleType() {
    if (state.homeModuleType == HomeModuleType.listTravels) {
      emit(IdleHomeState(homeModuleType: HomeModuleType.createTravel));
    } else {
      emit(IdleHomeState(homeModuleType: HomeModuleType.listTravels));
    }
  }
}
