import 'package:bloc/bloc.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/guest_model.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_guest_repository.dart';

import '../states/guest_travel_state.dart';

class GuestTravelCubit extends Cubit<IGuestTravelState> {
  GuestTravelCubit({
    required IGuestRepository guestRepository,
  })  : _guestRepository = guestRepository,
        super(const IdleGuestTravelState());

  final IGuestRepository _guestRepository;

  void deleteGuest(int guestId) async {
    await _guestRepository.deleteGuest(guestId);
    emit(SuccessDeletedGuestTravelListener(guestId: guestId));
  }

  void createGuest(List<String> emails, int travelId) async {
    List<GuestModel> guests = [];
    for (var email in emails) {
      var result = await _guestRepository.createGuest(email, travelId);
      if (result.isSuccess) {
        guests.add(result.guest!);
      }
    }
    if (guests.isNotEmpty) {
      emit(SuccessCreatedGuestTravelListener(guests: guests));
    }
  }

  Future<void> actionInviteGuest(String guestId, String action) async {
    final result = await _guestRepository.actionInviteGuest(guestId, action);
    if (result.isSuccess) {
      emit(const SuccessActionInviteGuestTravelListener());
    } else {
      emit(const FailureActionInviteGuestTravelListener());
    }
  }

  void updateList() {
    emit(const IdleGuestTravelState());
  }
}
