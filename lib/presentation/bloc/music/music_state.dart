part of 'music_bloc.dart';

@immutable
sealed class MusicState extends Equatable{
  const MusicState();

  @override
  List<Object> get props => [];
}

class MusicStateInitial extends MusicState{
  const MusicStateInitial();
}

class MusicStateLoading extends MusicState{
  const MusicStateLoading();
}

class MusicStateLoaded extends MusicState{
  const MusicStateLoaded({required this.file});
  final File file;

  @override
  List<Object> get props => [file];
}

class MusicStateError extends MusicState{
  const MusicStateError({this.ex});
  final AppException? ex;

  @override
  List<Object> get props => [ex??const UnknownError()];
}