part of 'input_bloc.dart';

abstract class InputEvent extends Equatable {
  const InputEvent();

  @override
  List<Object> get props => [];
}

class SearchInputs extends InputEvent {
  final String query;
  const SearchInputs({
    required this.query,
  });
}

class LoadInputs extends InputEvent {}

class AddInputEvent extends InputEvent {
  final String name;
  final int quantity;
  final String unit;
  final String locationId;
  final String userId;

  const AddInputEvent({
    required this.name,
    required this.quantity,
    required this.unit,
    required this.locationId,
    required this.userId,
  });
}
