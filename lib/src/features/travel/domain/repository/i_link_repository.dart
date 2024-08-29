import '../../../../../core/utils/base_repository_result.dart';
import '../result/create_link_result.dart';

abstract class ILinkRepository {
  Future<CreateLinkResult> addLinkToTravel(
    String titleLink,
    String url,
    int travelId,
  );
  Future<IBaseResult> deleteLink(int linkId);
}
