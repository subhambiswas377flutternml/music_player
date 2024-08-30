import 'package:music_visualizer/data/data_service_provider.dart';
import 'package:music_visualizer/data/repository_impl/repository_impl.dart';

const repositoryProvider = RepositoryImpl(remoteDataSourceProvider, localDataSourceProvider);