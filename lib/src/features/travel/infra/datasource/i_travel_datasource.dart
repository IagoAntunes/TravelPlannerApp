import 'package:travelplannerapp/core/utils/base_service_response.dart';
import 'package:travelplannerapp/src/features/travel/domain/request/create_travel_request.dart';

abstract class ITravelDataSource {
  Future<IResponseData> fetchTravels();
  Future<IResponseData> createTravel(CreateTravelRequest request);
}
