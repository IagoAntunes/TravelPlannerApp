import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/result/create_guest_result.dart';

abstract class IGuestRepository {
  Future<IBaseResult> deleteGuest(int guestId);

  Future<CreateGuestResult> createGuest(String email, int travelId);

  Future<IBaseResult> actionInviteGuest(String guestId, String action);
}
