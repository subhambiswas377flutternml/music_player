part of 'music_bloc.dart';

@immutable
sealed class MusicEvent extends Equatable{
  const MusicEvent();

  @override
  List<Object> get props => [];
}

class InitMusic extends MusicEvent{
  const InitMusic();
}

class FetchMusic extends MusicEvent{
  const FetchMusic();
}