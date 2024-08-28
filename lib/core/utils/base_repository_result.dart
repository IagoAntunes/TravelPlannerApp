abstract class IBaseResult {
  final bool isSuccess;
  final String statusCode;
  final String statusMsg;

  IBaseResult({
    required this.isSuccess,
    required this.statusCode,
    required this.statusMsg,
  });
}

class BaseResult extends IBaseResult {
  BaseResult.success({
    super.isSuccess = true,
    required super.statusCode,
    required super.statusMsg,
  });
  BaseResult.failure({
    super.isSuccess = false,
    required super.statusCode,
    required super.statusMsg,
  });
}
