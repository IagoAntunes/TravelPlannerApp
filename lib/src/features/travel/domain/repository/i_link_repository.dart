import '../result/create_link_result.dart';

abstract class ILinkRepository {
  Future<CreateLinkResult> addLinkToTravel(
    String titleLink,
    String url,
    int travelId,
  );
}
