abstract class UseCase<T> {
  const UseCase() : super();
  Future<T> call();
}