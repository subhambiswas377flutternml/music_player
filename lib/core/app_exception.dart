abstract class AppException implements Exception{
  const AppException();
}


class ApiFetchError extends AppException{
  const ApiFetchError({this.message});

  final String? message;
}

class UnknownError extends AppException{
  const UnknownError({this.message});

  final String? message;
}

class InsertError extends AppException{
  const InsertError({this.message});

  final String? message;
}

class FunctionalError extends AppException{
  const FunctionalError({this.message});

  final String? message;
}