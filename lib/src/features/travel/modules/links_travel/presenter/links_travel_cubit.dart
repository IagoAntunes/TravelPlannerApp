import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_link_repository.dart';
import 'package:travelplannerapp/src/features/travel/modules/links_travel/presenter/states/create_link_travel_state.dart';

class LinksTravelCubit extends Cubit<ICreateLinkTravelState> {
  LinksTravelCubit({
    required ILinkRepository linkRepository,
  })  : _linkRepository = linkRepository,
        super(IdleCreateLinkTravelState());

  final ILinkRepository _linkRepository;

  void addLinkToTravel(String titleLink, String url, int travelId) async {
    emit(LoadingCreateLinkTravelState());
    var result =
        await _linkRepository.addLinkToTravel(titleLink, url, travelId);
    if (result.isSuccess) {
      emit(SuccessCreateLinkTravelListener(
        link: result.link!,
      ));
    } else {
      emit(FailureCreateLinkTravelListener());
    }
    emit(IdleCreateLinkTravelState());
  }
}
