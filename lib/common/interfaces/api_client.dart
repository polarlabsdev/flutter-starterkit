import 'package:dio/browser.dart';
import 'package:dio/dio.dart';
import 'package:example_app/common/helpers/constants.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

// This error showed up out of nowhere, possibly after updating the Flutter/Dart SDK?
// https://github.com/cfug/dio/issues/2282
// https://github.com/dart-lang/sdk/issues/56498
// If you try to use BrowserHttpClientAdapter directly, you will get an error
// This is the workaround for now:
HttpClientAdapter makeHttpClientAdapter() {
  final adapter = HttpClientAdapter() as BrowserHttpClientAdapter;
  adapter.withCredentials = false;
  return adapter;
}

class ApiClient {
  late final Dio _dio;

  ApiClient() {
    _dio = Dio();
    _configureDioClient();
  }

  void _configureDioClient() {
    _dio.options.baseUrl = apiUrl;

    if (logHttpRequests) {
      _dio.interceptors.add(PrettyDioLogger());
    }

    if (kIsWeb) {
      // Web platform
      _dio.httpClientAdapter = makeHttpClientAdapter();
    }
  }

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters = const {},
    Map<String, dynamic>? headers = const {},
  }) async {
    return await _dio.get(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> post(
    String path,
    Object data, {
    Map<String, dynamic>? queryParameters = const {},
    Map<String, dynamic>? headers = const {},
  }) async {
    return await _dio.post(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> put(
    String path,
    Object data, {
    Map<String, dynamic>? queryParameters = const {},
    Map<String, dynamic>? headers = const {},
  }) async {
    return await _dio.put(
      path,
      data: data,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }

  Future<Response> delete(
    String path, {
    Map<String, dynamic>? queryParameters = const {},
    Map<String, dynamic>? headers = const {},
  }) async {
    return await _dio.delete(
      path,
      queryParameters: queryParameters,
      options: Options(headers: headers),
    );
  }
}
