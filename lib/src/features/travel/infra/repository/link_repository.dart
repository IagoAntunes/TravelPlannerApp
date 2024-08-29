import 'package:travelplannerapp/src/features/travel/domain/repository/i_link_repository.dart';
import 'package:travelplannerapp/src/features/travel/infra/datasource/i_link_datasource.dart';

import '../../../../../core/utils/base_service_response.dart';
import '../../domain/adapter/link_adapter.dart';
import '../../domain/request/create_link_request.dart';
import '../../domain/result/create_link_result.dart';

class LinkRepository extends ILinkRepository {
  LinkRepository({required ILinkDataSource linkDataSource})
      : _linkDataSource = linkDataSource;

  final ILinkDataSource _linkDataSource;

  @override
  Future<CreateLinkResult> addLinkToTravel(
      String titleLink, String url, int travelId) async {
    var request = CreateLinkRequest(
      name: titleLink,
      url: url,
      travelId: travelId,
    );
    var response = await _linkDataSource.createLink(request);
    if (response is SuccessResponseData) {
      return CreateLinkResult.success(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
        link: response.data['link'] != null
            ? LinkAdapter.fromMap(response.data['link'])
            : null,
      );
    } else {
      response as ErrorResponseData;
      return CreateLinkResult.failure(
        statusCode: response.statusCode,
        statusMsg: response.statusMsg,
      );
    }
  }
}
