

import 'package:dio/dio.dart';

abstract class HttpResult<T> {

  final T? data;
  final DioException? error;

  const HttpResult({this.data, this.error});
} 

class ResultSuccess<T> extends HttpResult<T> {
  const ResultSuccess(T data) : super(data: data);
}

class ResultError<T> extends HttpResult<T> {
  const ResultError(DioException error) : super(error: error);
}


