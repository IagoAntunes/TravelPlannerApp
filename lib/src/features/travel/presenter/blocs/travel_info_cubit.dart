import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_travel_repository.dart';

import '../../../auth/presenter/blocs/auth_cubit.dart';
import '../states/travel_info_state.dart';

enum EnumActivityTravelType {
  activities,
  details,
}

class TravelInfoCubit extends Cubit<ITravelInfoState> {
  TravelInfoCubit({
    required ITravelsRepository travelRepository,
  })  : _travelRepository = travelRepository,
        super(IdleTravelInfoState(
          type: EnumActivityTravelType.activities,
        ));

  final ITravelsRepository _travelRepository;

  late TravelModel travel;
  List<String> dateList = [];
  void changeActivityTravelType(EnumActivityTravelType type) {
    emit(IdleTravelInfoState(type: type));
  }

  void initTravel(TravelModel travel) {
    this.travel = travel;
  }

  Future<void> deleteTravel(int travelId) async {
    emit(LoadingDeleteTravelInfoListener(type: state.type));
    var result = await _travelRepository.deleteTravel(travelId);
    if (result.isSuccess) {
      emit(SuccessDeleteTravelInfoListener(type: state.type));
    } else {
      emit(FailureDeleteTravelInfoListener(type: state.type));
    }
  }

  bool hasPermission() {
    var authCubit = GetIt.I.get<AuthCubit>();
    if (authCubit.state.user != null &&
        authCubit.state.user!.name == travel.createdBy) {
      return true;
    }
    return false;
  }
}
