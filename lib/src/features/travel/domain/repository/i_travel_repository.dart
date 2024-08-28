import 'package:travelplannerapp/src/features/travel/domain/result/create_travel_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/result/fetch_travels_result.dart';

import '../../../../../core/utils/base_repository_result.dart';
import '../result/create_activity_result.dart';
import '../result/fetch_activities_result.dart';

abstract class ITravelsRepository {
  Future<FetchTravelsResult> fetchTravels();
  Future<FetchActivitiesResult> fetchActivities(int travelId);
  Future<CreateActivityResult> createActivity(
    String name,
    String dateTime,
    int travelId,
  );
  Future<IBaseResult> deleteActivity(
    int activityId,
  );
  Future<CreateTravelResult> createTravel(
    String localName,
    String startDate,
    String endDate,
    List<String> guests,
  );

  Future<IBaseResult> deleteTravel(int travelId);
}
