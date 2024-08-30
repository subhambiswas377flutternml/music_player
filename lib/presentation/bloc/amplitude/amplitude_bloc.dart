import 'dart:io';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:music_visualizer/core/app_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/core/data_state.dart';
import 'package:music_visualizer/core/utils.dart';

part 'amplitude_event.dart';
part 'amplitude_state.dart';

class AmplitudeBloc extends Bloc<AmplitudeEvent, AmplitudeState>{
  AmplitudeBloc():super(const AmplitudeStateInitial()){
    on<ExtractAmplitude>(extractAmplitude);
  }

  Future<void> extractAmplitude(ExtractAmplitude event, Emitter<AmplitudeState> emit) async{
    emit(const AmplitudeStateExtracting());

    final response = await Utils.getFrequencies(file: event.file);
    switch(response){
      case DataStateSuccess<List<double>>(data: var data):
        emit(AmplitudeStateExtracted(data: data));
      case DataStateError<List<double>>(ex: var ex):
        emit(AmplitudeStateError(ex: ex));
    }
  }
}