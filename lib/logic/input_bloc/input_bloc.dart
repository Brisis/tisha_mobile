import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/data/repositories/input/input_repository.dart';

part 'input_event.dart';
part 'input_state.dart';

class InputBloc extends Bloc<InputEvent, InputState> {
  final InputRepository inputRepository;
  InputBloc({
    required this.inputRepository,
  }) : super(InputStateInitial()) {
    on<LoadInputs>((event, emit) async {
      emit(InputStateLoading());
      try {
        final inputs = await inputRepository.getInputs();

        emit(LoadedInputs(inputs: inputs));
      } on AppException catch (e) {
        emit(
          InputStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          InputStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<SearchInputs>((event, emit) async {
      emit(InputStateSearchLoading());
      try {
        final inputs = await inputRepository.getInputs();

        final filtered = inputs
            .where((input) =>
                input.name.toLowerCase().contains(event.query.toLowerCase()))
            .toList();

        emit(
          LoadedInputs(inputs: filtered),
        );
      } on AppException catch (e) {
        emit(
          InputStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          InputStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });
  }
}
