part of 'file_usecases.dart';

const getFileUseCaseProvider = GetFileuseCase(repositoryProvider);

class GetFileuseCase extends UseCase<DataState<File>>{
  final Repository _repository;
  const GetFileuseCase(this._repository);

  @override
  Future<DataState<File>> call() async{
    return _repository.getFile();
  }
}