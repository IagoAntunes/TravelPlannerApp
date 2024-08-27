import 'dart:io';

import 'package:dio/dio.dart';
import 'package:travelplannerapp/core/utils/app_routes_api.dart';
import 'package:travelplannerapp/core/utils/base_service_response.dart';
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
        return ResponseData.success(response.data);
      } else {
        return ResponseData.error(response.data);
      }
    } on DioException catch (e) {
      return ResponseData.error({});
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
        return ResponseData.success(response.data);
      } else {
        return ResponseData.error(response.data);
      }
    } catch (e) {
      return ResponseData.error({});
    }
  }

  @override
  Future<IResponseData> fetchActivitiesByTravel(int travelId) async {
    try {
      final response = await _httpService.get(
        "${AppRoutesApi.getActivitiesByTravel}/$travelId",
      );
      if (response.statusCode == HttpStatus.ok) {
        return ResponseData.success(response.data);
      } else {
        return ResponseData.error(response.data);
      }
    } catch (e) {
      return ResponseData.error({
        'statusCode': '500',
        'statusMsg': 'Internal Server Error',
      });
    }
  }
}
