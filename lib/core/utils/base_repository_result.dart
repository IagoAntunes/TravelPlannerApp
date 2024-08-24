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
