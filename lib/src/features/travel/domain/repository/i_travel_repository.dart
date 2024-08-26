import 'package:travelplannerapp/src/features/travel/domain/result/fetch_travels_result.dart';

abstract class ITravelsRepository {
  Future<FetchTravelsResult> fetchTravels();
}
