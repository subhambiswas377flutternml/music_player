import 'package:http/http.dart';
import 'package:music_visualizer/core/api_manager.dart';
import 'package:music_visualizer/data/api_response.dart';
import 'package:music_visualizer/data/enums/endpoints.dart';

class RemoteDataSource{
  final ApiManager _apiManager;
  const RemoteDataSource(this._apiManager);

  Future<ApiResponse<Response>> getFile() async{
    return _apiManager.getAsync(url: EndPoints.getAudio.val());
  }
}