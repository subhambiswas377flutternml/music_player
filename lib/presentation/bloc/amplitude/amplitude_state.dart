part of 'amplitude_bloc.dart';

@immutable
sealed class AmplitudeState extends Equatable{
  const AmplitudeState();

  @override
  List<Object> get props => [];
}


class AmplitudeStateInitial extends AmplitudeState{
  const AmplitudeStateInitial();
}

class AmplitudeStateExtracting extends AmplitudeState{
  const AmplitudeStateExtracting();
}

class AmplitudeStateExtracted extends AmplitudeState{
  const AmplitudeStateExtracted({required this.data});

  final List<double> data;

  @override
  List<Object> get props => [data];
}

class AmplitudeStateError extends AmplitudeState{
  const AmplitudeStateError({this.ex});

  final AppException? ex;

  @override
  List<Object> get props => [ex??const UnknownError()];
}