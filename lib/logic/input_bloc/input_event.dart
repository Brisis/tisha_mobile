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
