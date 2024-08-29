import 'dart:io';

import 'package:dio/dio.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_link_datasource.dart';

import '../../../../core/utils/app_routes_api.dart';
import '../../../../core/utils/base_service_response.dart';
import '../domain/request/create_link_request.dart';

class LinkDataSource implements ILinkDataSource {
  LinkDataSource({required Dio httpService}) : _httpService = httpService;
  final Dio _httpService;
  @override
  Future<IResponseData> createLink(CreateLinkRequest request) async {
    try {
      final response = await _httpService.post(
        AppRoutesApi.createLink,
        data: request.toMap(),
      );
      if (response.statusCode == HttpStatus.created) {
        return ResponseData.success(response.data, response.statusCode!);
      } else {
        return ResponseData.error(response.data);
      }
    } on DioException catch (e) {
      return ResponseData.error(e.response!.data);
    }
  }

  @override
  Future<IResponseData> deleteLink(int linkId) async {
    try {
      final response = await _httpService.delete(
        "${AppRoutesApi.deleteLink}/$linkId",
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
