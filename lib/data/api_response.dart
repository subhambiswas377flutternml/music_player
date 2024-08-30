import 'package:flutter/material.dart';
import 'package:music_visualizer/core/app_exception.dart';

@immutable
sealed class ApiResponse<T>{
  const ApiResponse();
}

class ApiResponseSuccess<T> extends ApiResponse<T>{
  const ApiResponseSuccess({required this.data});

  final T data;
}

class ApiResponseError<T> extends ApiResponse<T>{
  const ApiResponseError({this.ex});
  final AppException? ex;
}