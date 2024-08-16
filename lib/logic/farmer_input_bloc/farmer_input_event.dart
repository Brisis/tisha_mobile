part of 'farmer_input_bloc.dart';

abstract class FarmerInputEvent extends Equatable {
  const FarmerInputEvent();

  @override
  List<Object> get props => [];
}

class SearchFarmerInputs extends FarmerInputEvent {
  final String userId;
  final String query;
  const SearchFarmerInputs({
    required this.userId,
    required this.query,
  });
}

class LoadAllFarmerInputs extends FarmerInputEvent {}

class LoadFarmerInputs extends FarmerInputEvent {
  final String userId;
  const LoadFarmerInputs({
    required this.userId,
  });
}

class AddFarmerInputEvent extends FarmerInputEvent {
  final int quantity;
  final String inputId;
  final String applicationId;
  final String userId;

  const AddFarmerInputEvent({
    required this.quantity,
    required this.inputId,
    required this.applicationId,
    required this.userId,
  });
}

class UpdateFarmerInputEvent extends FarmerInputEvent {
  final String userId;
  final double payback;
  final String inputId;
  final bool received;

  const UpdateFarmerInputEvent({
    required this.userId,
    required this.payback,
    required this.inputId,
    required this.received,
  });
}
