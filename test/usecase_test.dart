import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:music_visualizer/core/data_state.dart';
import 'package:music_visualizer/domain/repository/repository.dart';
import 'package:music_visualizer/domain/usecases/file_usecases.dart';

class MockRepository extends Mock implements Repository{
  @override
  Future<DataState<File>> getFile(){
    return Future.value(DataStateSuccess<File>(data: File("DummyPath")));
  }
}

void main(){
  late final MockRepository repository;
  late final GetFileuseCase getFileuseCase;
  setUpAll((){
    repository = MockRepository();
    getFileuseCase = GetFileuseCase(repository);
  });
  tearDownAll((){});

  test("Testing get file usecase", () async{
    final actualResponse = await getFileuseCase();
    expect(actualResponse, isA<DataState<File>>());
  });
}