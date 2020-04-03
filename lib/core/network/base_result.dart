import 'package:dio/dio.dart';

abstract class Data {}

typedef DataParser<T extends Data> = T Function(Map<String, dynamic> json);

typedef OnResultListener = void Function(BaseResult message);

class BaseResult<T extends Data> {
  final Meta diagnostic;
  final T data;
  final Response<Map<String, dynamic>> httpResponse;

  BaseResult(this.diagnostic, this.data, this.httpResponse);

  bool isSuccess() => httpResponse?.statusCode == 200;
  bool isErrorConnection() => this.diagnostic == Meta.errorConnection;

  static BaseResult errorServer<T extends Data>() {
    return BaseResult<T>(
      Meta.errorServer,
      null,
      null,
    );
  }

  static BaseResult errorConnection<T extends Data>() {
    return BaseResult<T>(
      Meta.errorConnection,
      null,
      null,
    );
  }

  static BaseResult canceled<T extends Data>() {
    return BaseResult<T>(
      Meta.canceled,
      null,
      null,
    );
  }
}

class Meta {
  final int code;
  final String errorMessage;
  final String errorType;
  final String userMessage;
  final bool isCanceled;

  Meta(
    this.code,
    this.errorMessage,
    this.errorType,
    this.userMessage, {
    this.isCanceled = false,
  });

  factory Meta.fromJson(Map<String, dynamic> parsedJson) {
    return Meta(
      parsedJson['code'],
      parsedJson['errorMessage'],
      parsedJson['errorType'],
      parsedJson['userMessage'],
      isCanceled: parsedJson['isCanceled'],
    );
  }

  static Meta errorConnection = Meta(
    0,
    'Koneksi terputus',
    'CONNECTION_ERROR',
    'hubungkan kembali ponsel ke internet',
  );

  static Meta errorServer = Meta(
    1,
    'Koneksi kurang stabil',
    'ERROR_SERVER',
    'Silahkan coba lagi!',
  );

  static Meta canceled = Meta(
    2,
    'Request di cancel',
    'CANCELED_REQUEST',
    'Silahkan coba lagi!',
    isCanceled: true,
  );
}
