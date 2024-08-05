part of 'farmer_input_bloc.dart';

abstract class FarmerInputState extends Equatable {
  const FarmerInputState();

  @override
  List<Object> get props => [];
}

final class FarmerInputStateInitial extends FarmerInputState {}

class FarmerInputStateSearchLoading extends FarmerInputState {}

class FarmerInputStateLoading extends FarmerInputState {}

class LoadedFarmerInputs extends FarmerInputState {
  final List<FarmerInput> inputs;
  const LoadedFarmerInputs({
    required this.inputs,
  });

  @override
  List<Object> get props => [inputs];

  @override
  bool? get stringify => true;
}

class FarmerInputStateError extends FarmerInputState {
  final AppException? message;
  const FarmerInputStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

extension GetInputs on FarmerInputState {
  List<FarmerInput> get inputs {
    final cls = this;
    if (cls is LoadedFarmerInputs) {
      return cls.inputs;
    } else {
      return [];
    }
  }
}
