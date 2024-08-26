import 'package:travelplannerapp/src/features/travel/domain/result/create_travel_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/result/fetch_travels_result.dart';

abstract class ITravelsRepository {
  Future<FetchTravelsResult> fetchTravels();
  Future<CreateTravelResult> createTravel(
    String localName,
    String startDate,
    String endDate,
    List<String> guests,
  );
}
