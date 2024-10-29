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

class NotifyInput extends InputEvent {
  final String inputId;

  const NotifyInput({
    required this.inputId,
  });
}

class AddInputEvent extends InputEvent {
  final String name;
  final int quantity;
  final String? unit;
  final String type;
  final String scheme;
  final String barcode;
  final String? chassisNumber;
  final String? engineType;
  final String? numberPlate;
  final String? color;
  final String locationId;
  final String userId;

  const AddInputEvent({
    required this.name,
    required this.quantity,
    this.unit,
    required this.type,
    required this.scheme,
    required this.barcode,
    this.chassisNumber,
    this.engineType,
    this.numberPlate,
    this.color,
    required this.locationId,
    required this.userId,
  });
}
