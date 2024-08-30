import 'dart:io';

import 'package:music_visualizer/core/data_state.dart';

abstract interface class Repository{
  Future<DataState<File>> getFile();
}