import 'package:bloc/bloc.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_travel_repository.dart';
import 'package:travelplannerapp/src/features/travel/modules/create_travel/presenter/states/create_travel_state.dart';

enum CreateTravelStep {
  initial,
  guests,
}

class CreateTravelCubit extends Cubit<ICreateTravelState> {
  CreateTravelCubit({required ITravelsRepository repository})
      : _travelsRepository = repository,
        super(
          IdleCreateTravelState(
            createTravelStep: CreateTravelStep.initial,
          ),
        );
  final ITravelsRepository _travelsRepository;

  List<String> emailGuests = [];

  String _localName = '';
  set setLocalName(String value) => _localName = value;
  String _startDate = '';
  set setStartDate(String value) => _startDate = value;
  String _endDate = '';
  set setEndDate(String value) => _endDate = value;

  void changeStepToGuests() {
    emit(IdleCreateTravelState(createTravelStep: CreateTravelStep.guests));
  }

  void changeStepToInitial() {
    emit(IdleCreateTravelState(createTravelStep: CreateTravelStep.initial));
  }

  void cleanProps() {
    emailGuests = [];
    _localName = '';
    _startDate = '';
    _endDate = '';
  }

  void createTravel() async {
    emit(LoadingCreateTravelState(createTravelStep: state.createTravelStep));

    var result = await _travelsRepository.createTravel(
      _localName,
      _startDate,
      _endDate,
      emailGuests,
    );

    if (result.isSuccess) {
      emit(CreatedTravelListener(createTravelStep: state.createTravelStep));
    } else {
      emit(FailureCreateTravelListener(
          createTravelStep: state.createTravelStep));
    }

    emit(IdleCreateTravelState(createTravelStep: state.createTravelStep));
  }
}
