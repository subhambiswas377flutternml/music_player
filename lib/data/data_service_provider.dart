import 'package:music_visualizer/core/api_manager.dart';
import 'package:music_visualizer/data/data_source/local_data_source.dart';
import 'package:music_visualizer/data/data_source/remote_data_source.dart';

const apiManagerProvider = ApiManager();
const localDataSourceProvider = LocalDataSource();
const remoteDataSourceProvider = RemoteDataSource(apiManagerProvider);