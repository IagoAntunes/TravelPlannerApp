import 'package:travelplannerapp/core/utils/base_repository_result.dart';
import 'package:travelplannerapp/src/features/travel/domain/model/link_model.dart';

class CreateLinkResult extends IBaseResult {
  CreateLinkResult.success({
    super.isSuccess = true,
    required super.statusCode,
    required super.statusMsg,
    required this.link,
  });
  CreateLinkResult.failure({
    super.isSuccess = false,
    required super.statusCode,
    required super.statusMsg,
  });

  LinkModel? link;
}
