import 'dart:io';

import 'package:dio/dio.dart';
import 'package:travelplannerapp/core/utils/app_routes_api.dart';
import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_activity_request.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_travel_request.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_travel_datasource.dart';

class TravelDataSource extends ITravelDataSource {
  TravelDataSource({required Dio httpService}) : _httpService = httpService;
  final Dio _httpService;
  @override
  Future<IResponseData> fetchTravels() async {
    try {
      final response = await _httpService.get(AppRoutesApi.getTravelByUser);
      if (response.statusCode == HttpStatus.ok) {
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
  Future<IResponseData> createTravel(CreateTravelRequest request) async {
    try {
      final response = await _httpService.post(
        AppRoutesApi.createTravel,
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
  Future<IResponseData> fetchActivitiesByTravel(int travelId) async {
    try {
      final response = await _httpService.get(
        "${AppRoutesApi.getActivitiesByTravel}/$travelId",
      );
      if (response.statusCode == HttpStatus.ok) {
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
  Future<IResponseData> createActivity(CreateActivityRequest request) async {
    try {
      final response = await _httpService.post(
        AppRoutesApi.createActivity,
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
  Future<IResponseData> deleteActivity(int activityId) async {
    try {
      final response = await _httpService.delete(
        '${AppRoutesApi.deleteActivity}/$activityId',
      );
      if (response.statusCode == HttpStatus.noContent) {
        return ResponseData.success(response.data, response.statusCode!);
      } else {
        return ResponseData.error(response.data);
      }
    } on DioException catch (e) {
      return ResponseData.error(e.response!.data);
    }
  }

  @override
  Future<IResponseData> deleteTravel(int travelId) async {
    try {
      final response = await _httpService.delete(
        '${AppRoutesApi.deleteTravel}/$travelId',
      );
      if (response.statusCode == HttpStatus.noContent) {
        return ResponseData.success(response.data, response.statusCode!);
      } else {
        return ResponseData.error(response.data);
      }
    } on DioException catch (e) {
      return ResponseData.error(e.response!.data);
    }
  }
}
