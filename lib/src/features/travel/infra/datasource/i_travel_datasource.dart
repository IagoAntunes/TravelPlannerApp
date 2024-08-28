import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_activity_request.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_travel_request.dart';

abstract class ITravelDataSource {
  Future<IResponseData> fetchTravels();
  Future<IResponseData> fetchActivitiesByTravel(int travelId);
  Future<IResponseData> createActivity(CreateActivityRequest request);
  Future<IResponseData> deleteActivity(int activityId);
  Future<IResponseData> createTravel(CreateTravelRequest request);
  Future<IResponseData> deleteTravel(int travelId);
}
