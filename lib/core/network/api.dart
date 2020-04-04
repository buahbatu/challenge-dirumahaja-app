import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dirumahaja/core/network/base_result.dart';
import 'package:dirumahaja/core/network/remote_env.dart';
import 'package:flutter/material.dart';

class Api {
  final Dio _dio;
  Api._internal({Dio dio}) : this._dio = dio ?? Dio(defaultOptions);

  Dio getDio() => _dio;

  static final defaultOptions = BaseOptions(
    baseUrl: parseDomain(),
    connectTimeout: 180000,
    receiveTimeout: 180000,
    contentType: ContentType.json.toString(),
  );

  static Api _singleton;
  factory Api({String secret}) {
    if (_singleton == null) _singleton = Api._internal();
    if (secret != null)
      _singleton._dio
        ..options.headers.addAll({
          "secret": secret,
          HttpHeaders.acceptHeader: ContentType.json.toString(),
        });
    return _singleton;
  }

  static void reset() {
    _singleton = null;
  }

  static String parseDomain({bool isGetRoot = false}) {
    RemoteEnv env = RemoteEnv.get();
    if (env == null) env = RemoteEnv.PRODUCTION;

    String domain = '${env.protocol}://${env.domain}';
    if (env.port.isNotEmpty) {
      domain = '${env.protocol}://${env.domain}:${env.port}';
    }
    // if (!isGetRoot) domain += '/api';
    return domain;
  }

  Future<BaseResult<T>> _onError<T extends Data>(dynamic error) async {
    try {
      if (error is DioError && error.error is SocketException) {
        throw BaseResult.errorConnection<T>();
      } else if (error is DioError && error.type == DioErrorType.CANCEL) {
        throw BaseResult.canceled<T>();
      } else if (error is DioError &&
          error.type == DioErrorType.RESPONSE &&
          error.response.data is Map) {
        final result = error.response.data as Map<String, dynamic>;
        if (!result.containsKey('meta')) throw BaseResult.errorServer<T>();
        throw BaseResult<T>(
          Meta.fromJson(result['meta'] ?? {}),
          null,
          null,
        );
      } else {
        // special dio, only used on error
        final google = await Dio(BaseOptions(
          connectTimeout: 180000,
          receiveTimeout: 180000,
        )).get("https://google.com");
        if (google.statusCode == 200) {
          throw BaseResult.errorServer<T>();
        } else {
          throw BaseResult.errorConnection<T>();
        }
      }
    } catch (data) {
      return data;
    }
  }

  BaseResult<T> _onResult<T extends Data>(
    Response<Map<String, dynamic>> response,
    DataParser<T> dataParser,
  ) {
    final result = response.data;
    return BaseResult(
      result.containsKey('meta') ? Meta.fromJson(result['meta'] ?? {}) : null,
      result.containsKey('data') && dataParser != null
          ? dataParser(result['data'] ?? {})
          : null,
      response,
    );
  }

  Future<BaseResult<T>> _runRequest<T extends Data>(
    Future<Response<Map<String, dynamic>>> request,
    DataParser<T> dataParser,
  ) async {
    try {
      Response<Map<String, dynamic>> response = await request;
      return _onResult(response, dataParser);
    } catch (error) {
      return _onError<T>(error);
    }
  }

  void cancel(CancelToken token) {
    // cancel the requests with "cancelled" message.
    token?.cancel("cancelled");
  }

  Future<BaseResult<T>> post<T extends Data>({
    @required String path,
    @required DataParser<T> dataParser,
    dynamic body,
    Map<String, dynamic> headers,
    CancelToken token,
  }) async {
    final request = _dio.post<Map<String, dynamic>>(
      path,
      data: body,
      options: Options(contentType: 'application/json', headers: headers),
      cancelToken: token,
    );

    return await _runRequest(request, dataParser);
  }

  Future<BaseResult<T>> patch<T extends Data>({
    @required String path,
    @required DataParser<T> dataParser,
    FormData form,
    Map<String, dynamic> headers,
    CancelToken token,
  }) async {
    final request = _dio.patch<Map<String, dynamic>>(
      path,
      data: form,
      options: Options(headers: headers),
      cancelToken: token,
    );

    return await _runRequest(request, dataParser);
  }

  Future<BaseResult<T>> get<T extends Data>({
    @required String path,
    @required DataParser<T> dataParser,
    Map<String, dynamic> queryParam,
    Map<String, dynamic> headers,
    CancelToken token,
  }) async {
    final request = _dio.get<Map<String, dynamic>>(
      path,
      queryParameters: queryParam,
      options: Options(headers: headers),
      cancelToken: token,
    );

    return await _runRequest(request, dataParser);
  }
}
