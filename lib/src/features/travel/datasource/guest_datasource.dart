import 'dart:io';

import 'package:dio/dio.dart';
import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_guest_request.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_guest_datasource.dart';

import '../../../../core/utils/app_routes_api.dart';
import '../domain/request/action_invite_guest.dart';

class GuestDataSource extends IGuestDataSource {
  GuestDataSource({required Dio httpService}) : _httpService = httpService;
  final Dio _httpService;

  @override
  Future<IResponseData> deleteGuest(int guestId) async {
    try {
      final response =
          await _httpService.delete('${AppRoutesApi.deleteGuest}/$guestId');
      if (response.statusCode == HttpStatus.noContent) {
        return ResponseData.success(
          response.data,
          response.statusCode!,
        );
      } else {
        return ResponseData.error(response.data);
      }
    } on DioException catch (e) {
      return ResponseData.error(e.response!.data);
    }
  }

  @override
  Future<IResponseData> createGuest(CreateGuestRequest request) async {
    try {
      final response = await _httpService.post(
        AppRoutesApi.createGuest,
        data: request.toMap(),
      );
      if (response.statusCode == HttpStatus.created) {
        return ResponseData.success(
          response.data,
          response.statusCode!,
        );
      } else {
        return ResponseData.error(response.data);
      }
    } on DioException catch (e) {
      return ResponseData.error(e.response!.data);
    }
  }

  @override
  Future<IResponseData> actionInviteGuest(ActionInviteGuest request) async {
    try {
      final response = await _httpService.post(
        AppRoutesApi.actionInviteGuest,
        data: request.toMap(),
      );
      if (response.statusCode == HttpStatus.created) {
        return ResponseData.success(
          response.data,
          response.statusCode!,
        );
      } else {
        return ResponseData.error(response.data);
      }
    } on DioException catch (e) {
      return ResponseData.error(e.response!.data);
    }
  }
}
