import 'dart:async';
import 'dart:developer' as dev;
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../../storage/domain/secure_storage.dart';
import '../domain/http_response.dart';
import '../domain/http_service.dart';
import 'http_exceptions_imp.dart';

class HttpServiceImp implements IHttpService {
  final Dio _dio = Dio();
  late ISecureStorage _storage;
  HttpServiceImp() {
    _storage = GetIt.I.get<ISecureStorage>();
    _dio.options.validateStatus = (status) {
      return true;
    };
    // BaseOptions options = BaseOptions(
    //   followRedirects: false,
    //   validateStatus: (statusCode) => true,
    //   baseUrl: url,
    //   contentType: Headers.jsonContentType,
    // );
    // _dio.options = options;
    // _dio.interceptors
    //     .addAll([AuthenticationInterceptor(secureStorage: _storage)]);
  }
  Future<HttpResponse<T>?> _executeRequest<T>(
    Future<Response> Function() executionFunction, {
    Duration? timeOut,
  }) async {
    try {
      var response = await executionFunction();
      return _dioResponseConverter(response);
    } on TimeoutException catch (e) {
      dev.log(e.message!);
      throw RequestTimeoutException(message: e.message);
    } on DioException catch (e) {
      dev.log(e.toString());
      switch (e.error) {
        case SocketException():
          throw InternetException(message: e.message);
        case AuthenticationException():
          throw AuthenticationException();
        default:
      }
      return null;
    }
  }

  @override
  Future<HttpResponse<T>?> get<T>(String url,
      {Map<String, dynamic>? queryParameters, Duration? timeOut}) async {
    return _executeRequest(
        () => _dio.get(url, queryParameters: queryParameters),
        timeOut: timeOut);
  }

  @override
  Future<HttpResponse<T>?> post<T>(
    String url,
    data, {
    Map<String, dynamic>? queryParameters,
    Duration? timeOut,
  }) async {
    final response =
        await _dio.post(url, data: data, queryParameters: queryParameters);
  }

  @override
  Future<HttpResponse<T>?> patch<T>(String url, data,
      {Map<String, dynamic>? queryParameters, bool retry = true}) async {
    return _executeRequest(
        () => _dio.patch(url, data: data, queryParameters: queryParameters));
  }

  @override
  Future<HttpResponse<T>?> put<T>(String url, data,
      {Map<String, dynamic>? queryParameters, bool retry = true}) async {
    return _executeRequest(
        () => _dio.put(url, data: data, queryParameters: queryParameters));
  }

  @override
  Future<HttpResponse<T>?> delete<T>(String url, data,
      {Map<String, dynamic>? queryParameters, bool retry = true}) async {
    return _executeRequest(
        () => _dio.delete(url, data: data, queryParameters: queryParameters));
  }

  //Response Utils

  HttpResponse<T> _dioResponseConverter<T>(Response? response) {
    if (response != null) {
      _showLogOfResponse(response);
    }
    return HttpResponse<T>(
        statusCode: response?.statusCode,
        data: response?.data,
        headers: response?.headers.map);
  }

  void _showLogOfResponse(Response response) {
    dev.log(
      "[StatusCode: ${response.statusCode}] :: [Endpoint: ${response.realUri}] :: [Method: ${response.requestOptions.method.toUpperCase()}] :: [Header: ${response.requestOptions.headers}] :: [Body Response: ${response.data}]",
    );
  }
}
