import '../../../../../core/utils/base_service_response.dart';
import '../../domain/request/create_link_request.dart';

abstract class ILinkDataSource {
  Future<IResponseData> createLink(CreateLinkRequest request);
}
