import 'package:flutter/material.dart';
import 'package:music_visualizer/core/app_exception.dart';

@immutable
sealed class DataState<T>{
  const DataState();
}

class DataStateSuccess<T> extends DataState<T>{
  const DataStateSuccess({required this.data});

  final T data;
}

class DataStateError<T> extends DataState<T>{
  const DataStateError({this.ex});
  final AppException? ex;
}