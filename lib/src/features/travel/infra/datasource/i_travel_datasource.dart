import 'package:travelplannerapp/core/utils/base_service_response.dart';

abstract class ITravelDataSource {
  Future<IResponseData> fetchTravels();
}
