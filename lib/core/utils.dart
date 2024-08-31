import 'dart:developer';
import 'dart:io';
import 'package:music_visualizer/core/app_exception.dart';
import 'package:music_visualizer/core/data_state.dart';
import 'package:music_visualizer/core/extensions/list_extension.dart';
import 'package:waveform_extractor/waveform_extractor.dart';

typedef ListDouble = List<double>;

class Utils{
  static Future<DataState<ListDouble>> getFrequencies({required File file}) async{
    try{
      const int sampleNumber = 50;
      final waveformExtractor = WaveformExtractor();
      final result = await waveformExtractor.extractWaveform(file.path);
      final waveformData = result.waveformData.reduceListSize(targetSize: sampleNumber);

      log(file.path);
      log(waveformData.toString());
      return DataStateSuccess<ListDouble>(data: waveformData);
    }
    catch(ex){
      return const DataStateError<ListDouble>(ex: FunctionalError());
    }
  }


}