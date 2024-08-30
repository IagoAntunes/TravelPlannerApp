import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_guest_request.dart';

import '../../domain/request/action_invite_guest.dart';

abstract class IGuestDataSource {
  Future<IResponseData> deleteGuest(int guestId);

  Future<IResponseData> createGuest(CreateGuestRequest request);

  Future<IResponseData> actionInviteGuest(ActionInviteGuest request);
}
