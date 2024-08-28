import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/travel/domain/adapter/travel_adapter.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/travel_model.dart';
import 'package:travelplannerapp/src/features/travel/domain/repository/i_travel_repository.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_activity_request.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_travel_request.dart';
import 'package:travelplannerapp/src/features/travel/domain/result/create_travel_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/result/fetch_travels_result.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_travel_datasource.dart';

import '../../domain/adapter/activity_adapter.dart';
import '../../domain/model/activity_model.dart';
import '../../domain/result/create_activity_result.dart';
import '../../domain/result/fetch_activities_result.dart';

class TravelRepository extends ITravelsRepository {
  TravelRepository({required ITravelDataSource travelDataSource})
      : _travelDataSource = travelDataSource;

  final ITravelDataSource _travelDataSource;

  @override
  Future<FetchTravelsResult> fetchTravels() async {
    var response = await _travelDataSource.fetchTravels();
    if (response is SuccessResponseData) {
      List<TravelModel> travels = response.data['travels']
          .map<TravelModel>((travel) => TravelAdapter.fromMap(travel))
          .toList();

      return FetchTravelsResult.success(
        travels: travels,
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    } else {
      response as ErrorResponseData;
      return FetchTravelsResult.failure(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    }
  }

  @override
  Future<CreateTravelResult> createTravel(String localName, String startDate,
      String endDate, List<String> guests) async {
    var request = CreateTravelRequest(
      name: localName,
      startDate: startDate,
      endDate: endDate,
      guests: guests,
    );
    var response = await _travelDataSource.createTravel(request);
    if (response is SuccessResponseData) {
      return CreateTravelResult.success(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
        travel: response.data['travel'] != null
            ? TravelAdapter.fromMap(response.data['travel'])
            : null,
      );
    } else {
      response as ErrorResponseData;
      return CreateTravelResult.failure(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    }
  }

  @override
  Future<FetchActivitiesResult> fetchActivities(int travelId) async {
    final response = await _travelDataSource.fetchActivitiesByTravel(travelId);
    if (response is SuccessResponseData) {
      var listActivities = response.data['activities']
          .map<ActivityModel>((activity) => ActivityAdapter.fromMap(activity))
          .toList();

      return FetchActivitiesResult.success(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
        activities: listActivities,
      );
    } else {
      response as ErrorResponseData;
      return FetchActivitiesResult.failure(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    }
  }

  @override
  Future<CreateActivityResult> createActivity(
    String name,
    String dateTime,
    int travelId,
  ) async {
    var request = CreateActivityRequest(
      name: name,
      date: dateTime,
      travelId: travelId,
    );
    final response = await _travelDataSource.createActivity(request);
    if (response is SuccessResponseData) {
      //

      return CreateActivityResult.success(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    } else {
      response as ErrorResponseData;
      return CreateActivityResult.failure(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    }
  }
}
