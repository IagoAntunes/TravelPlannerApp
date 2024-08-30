import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/travel/domain/adapter/guest_adapter.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_guest_repository.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/action_invite_guest.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_guest_request.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_guest_datasource.dart';

import '../../domain/result/create_guest_result.dart';

class GuestRepository extends IGuestRepository {
  GuestRepository({required IGuestDataSource guestDataSource})
      : _guestDataSource = guestDataSource;

  final IGuestDataSource _guestDataSource;

  @override
  Future<IBaseResult> deleteGuest(int guestId) async {
    final response = await _guestDataSource.deleteGuest(guestId);
    if (response is SuccessResponseData) {
      return BaseResult.success(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    } else {
      return BaseResult.failure(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    }
  }

  @override
  Future<CreateGuestResult> createGuest(String email, int travelId) async {
    var request = CreateGuestRequest(
      email: email,
      travelId: travelId,
    );
    final response = await _guestDataSource.createGuest(request);
    if (response is SuccessResponseData) {
      return CreateGuestResult.success(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
        guest: GuestAdapter.fromMap(response.data['guest']),
      );
    } else {
      return CreateGuestResult.failure(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    }
  }

  @override
  Future<IBaseResult> actionInviteGuest(String guestId, String action) async {
    var request = ActionInviteGuest(guestId: guestId, action: action);
    final response = await _guestDataSource.actionInviteGuest(request);
    if (response is SuccessResponseData) {
      return BaseResult.success(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    } else {
      return BaseResult.failure(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    }
  }
}
