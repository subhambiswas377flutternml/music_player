import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:equatable/equatable.dart';
import 'package:music_visualizer/core/app_exception.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_visualizer/core/data_state.dart';
import 'package:music_visualizer/domain/usecases/file_usecases.dart';

part 'music_event.dart';
part 'music_state.dart';

class MusicBloc extends Bloc<MusicEvent, MusicState>{
  late final GetFileuseCase _getFile;
  MusicBloc():super(const MusicStateInitial()){
    on<InitMusic>(_init);
    on<FetchMusic>(fetchMusic);
  }

  void _init(event, emit){
    _getFile = getFileUseCaseProvider;
  }

  Future<void> fetchMusic(FetchMusic event, Emitter<MusicState> emit) async{
    emit(const MusicStateLoading());
    final response = await _getFile();

    switch(response){
      case DataStateSuccess<File>(data: File file):
        emit(MusicStateLoaded(file: file));
      case DataStateError(ex: var ex):
        emit(MusicStateError(ex: ex));
    }
  }
}