import 'dart:io';

import 'package:http/http.dart';
import 'package:music_visualizer/core/app_exception.dart';
import 'package:music_visualizer/core/data_state.dart';
import 'package:path_provider/path_provider.dart';

class LocalDataSource{
  const LocalDataSource();
  Future<DataState<File>> storeFile({required Response response}) async{
    try{
      final directory = await getApplicationDocumentsDirectory();
        final filePath = '${directory.path}/audio.mp3';
        if(await File(filePath).exists()){
          await File(filePath).delete();
        }
        final file = File(filePath);
        await file.writeAsBytes(response.bodyBytes);

        return DataStateSuccess<File>(data: file);
    }catch(ex){
      return const DataStateError<File>(ex: InsertError());
    }
  }
}