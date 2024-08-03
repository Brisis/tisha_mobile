part of 'input_bloc.dart';

abstract class InputState extends Equatable {
  const InputState();

  @override
  List<Object> get props => [];
}

final class InputStateInitial extends InputState {}

class InputStateSearchLoading extends InputState {}

class InputStateLoading extends InputState {}

class LoadedInputs extends InputState {
  final List<Input> inputs;
  const LoadedInputs({
    required this.inputs,
  });

  @override
  List<Object> get props => [inputs];

  @override
  bool? get stringify => true;
}

class InputStateError extends InputState {
  final AppException? message;
  const InputStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

extension GetInputs on InputState {
  List<Input> get inputs {
    final cls = this;
    if (cls is LoadedInputs) {
      return cls.inputs;
    } else {
      return [];
    }
  }
}
