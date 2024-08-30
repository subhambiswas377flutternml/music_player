import 'dart:io';

import 'package:music_visualizer/data/api_response.dart';
import 'package:music_visualizer/data/data_source/local_data_source.dart';
import 'package:music_visualizer/data/data_source/remote_data_source.dart';
import 'package:music_visualizer/domain/repository/repository.dart';

import '../../core/data_state.dart';

class RepositoryImpl implements Repository{
  final LocalDataSource _localDataSource;
  final RemoteDataSource _remoteDataSource;
  const RepositoryImpl(this._remoteDataSource, this._localDataSource);

  @override
  Future<DataState<File>> getFile() async{
    final response = await _remoteDataSource.getFile();

    switch(response){
      case ApiResponseSuccess(data: var file):
        return _localDataSource.storeFile(response: file);
      case ApiResponseError(ex: var ex):
        return DataStateError(ex: ex);
    }
  }
}