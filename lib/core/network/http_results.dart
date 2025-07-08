

import 'package:dio/dio.dart';

abstract class HttpResult<T> {

  final T? data;
  final DioException? error;
  final String? message;

  const HttpResult({this.data, this.error,this.message});
} 

class ResultSuccess<T> extends HttpResult<T> {
  const ResultSuccess(T data) : super(data: data);
}

class ResultError<T> extends HttpResult<T> {
  const ResultError(DioException error) : super(error: error);
}

class NoResult<T> extends HttpResult<T>{
  const NoResult(String message) : super(message: message);
}


