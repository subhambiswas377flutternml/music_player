part of 'amplitude_bloc.dart';

@immutable
sealed class AmplitudeEvent extends Equatable{
  const AmplitudeEvent();

  @override
  List<Object> get props => [];
}

class ExtractAmplitude extends AmplitudeEvent{
  const ExtractAmplitude({required this.file});

  final File file;

  @override
  List<Object> get props => [file];
}