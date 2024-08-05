part of 'farmer_input_bloc.dart';

abstract class FarmerInputEvent extends Equatable {
  const FarmerInputEvent();

  @override
  List<Object> get props => [];
}

class SearchFarmerInputs extends FarmerInputEvent {
  final String query;
  const SearchFarmerInputs({
    required this.query,
  });
}

class LoadFarmerInputs extends FarmerInputEvent {}

class AddFarmerInputEvent extends FarmerInputEvent {
  final List<String> inputs;
  final String userId;

  const AddFarmerInputEvent({
    required this.inputs,
    required this.userId,
  });
}
