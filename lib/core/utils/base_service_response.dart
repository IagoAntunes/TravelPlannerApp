import 'dart:convert';

abstract class IResponseData {
  final String statusCode;
  final String statusMsg;

  IResponseData(this.statusCode, this.statusMsg);
}

class SuccessResponseData extends IResponseData {
  final Map<String, dynamic> data;
  SuccessResponseData(
    super.statusCode,
    super.statusMsg, {
    required this.data,
  });

  factory SuccessResponseData.fromMap(Map<String, dynamic> map) {
    return SuccessResponseData(
      map['statusCode'] as String,
      map['statusMsg'] as String,
      data: map,
    );
  }

  factory SuccessResponseData.fromJson(String source) =>
      SuccessResponseData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ErrorResponseData extends IResponseData {
  ErrorResponseData(
    super.statusCode,
    super.statusMsg, {
    required this.apiPath,
    required this.errorCode,
    required this.errorMessage,
    required this.errorTime,
  });
  final String apiPath;
  final String errorCode;
  final String errorMessage;
  final String errorTime;

  factory ErrorResponseData.fromMap(Map<String, dynamic> map) {
    if (map.isEmpty) {
      ErrorResponseData(
        map['statusCode'] as String,
        map['statusMsg'] as String,
        apiPath: map['apiPath'] as String,
        errorCode: map['errorCode'] as String,
        errorMessage: map['errorMessage'] as String,
        errorTime: DateTime.now().toString(),
      );
    }
    return ErrorResponseData(
      map['statusCode'] as String,
      map['statusMsg'] as String,
      apiPath: map['apiPath'] as String,
      errorCode: map['errorCode'] as String,
      errorMessage: map['errorMessage'] as String,
      errorTime: map['errorTime'] as String,
    );
  }

  factory ErrorResponseData.fromJson(String source) =>
      ErrorResponseData.fromMap(json.decode(source) as Map<String, dynamic>);
}

class ResponseData {
  ResponseData._();

  static SuccessResponseData success(dynamic responseData, int statusCode) {
    if (statusCode == 204) {
      return SuccessResponseData(
        '200',
        'OK',
        data: {},
      );
    }
    return SuccessResponseData.fromMap(responseData);
  }

  static ErrorResponseData error(Map<String, dynamic> responseData) {
    return ErrorResponseData.fromMap(responseData);
  }

  static ErrorResponseData errorCatch() {
    return ErrorResponseData.fromMap({});
  }
}
