import 'package:http/http.dart' as http;
import 'package:http/http.dart';
import 'package:music_visualizer/core/app_exception.dart';
import 'package:music_visualizer/data/api_response.dart';

class ApiManager{
  const ApiManager();

  Future<ApiResponse<Response>> getAsync({required String url}) async{
    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        return ApiResponseSuccess<Response>(data: response);
      } else {
        return const ApiResponseError<Response>(ex: ApiFetchError());
      }
  } catch (e) {
    return const ApiResponseError<Response>(ex: UnknownError());
  }
  }
}