import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_travel_repository.dart';
import 'package:travelplannerapp/src/features/travel/modules/list_travels/presenter/states/list_travels_state.dart';

class ListTravelsCubit extends Cubit<IListTravelsState> {
  ListTravelsCubit({
    required ITravelsRepository travelRepository,
  })  : _travelRepository = travelRepository,
        super(IdleListTravelsState());

  final ITravelsRepository _travelRepository;

  void fetchTravels() async {
    emit(LoadingListTravelsState());
    var result = await _travelRepository.fetchTravels();
    if (result.isSuccess) {
      emit(SuccessListTravelsState(
        travels: result.travels,
      ));
    } else {
      emit(FailureListTravelsState());
    }
  }
}
