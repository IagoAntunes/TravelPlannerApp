import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_link_repository.dart';

import 'states/links_travel_state.dart';

class LinksTravelCubit extends Cubit<ILinksTravelState> {
  LinksTravelCubit({
    required ILinkRepository linkRepository,
  })  : _linkRepository = linkRepository,
        super(IdleLinksTravelState());

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
    emit(IdleLinksTravelState());
  }

  void deleteLink(int linkId) async {
    await _linkRepository.deleteLink(linkId);
    emit(SuccessDeletedLinkTravelListener(linkId: linkId));
  }

  void emitIdle() {
    emit(IdleLinksTravelState());
  }
}
