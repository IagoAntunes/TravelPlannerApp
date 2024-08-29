import 'package:travelplannerapp/src/features/travel/domain/model/guest_model.dart';

abstract class IGuestTravelState {
  const IGuestTravelState();
}

abstract class IGuestTravelListener extends IGuestTravelState {
  const IGuestTravelListener();
}

class SuccessDeletedGuestTravelListener extends IGuestTravelListener {
  const SuccessDeletedGuestTravelListener({required this.guestId});
  final int guestId;
}

class SuccessCreatedGuestTravelListener extends IGuestTravelListener {
  const SuccessCreatedGuestTravelListener({
    required this.guests,
  });

  final List<GuestModel> guests;
}

class IdleGuestTravelState extends IGuestTravelState {
  const IdleGuestTravelState();
}
