import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/storage.dart';
import 'package:tisha_app/data/models/farmer_input.dart';
import 'package:tisha_app/data/repositories/input/input_repository.dart';

part 'farmer_input_event.dart';
part 'farmer_input_state.dart';

class FarmerInputBloc extends Bloc<FarmerInputEvent, FarmerInputState> {
  final InputRepository inputRepository;
  FarmerInputBloc({
    required this.inputRepository,
  }) : super(FarmerInputStateInitial()) {
    on<LoadFarmerInputs>((event, emit) async {
      emit(FarmerInputStateLoading());
      try {
        final token = await getAuthToken();
        final inputs = await inputRepository.getFarmerInputs(
          token: token!,
          userId: event.userId,
        );

        emit(LoadedFarmerInputs(inputs: inputs));
      } on AppException catch (e) {
        emit(
          FarmerInputStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerInputStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<AddFarmerInputEvent>((event, emit) async {
      emit(FarmerInputStateLoading());
      try {
        final token = await getAuthToken();

        final inputs = await inputRepository.addFarmerInput(
          token: token!,
          inputId: event.inputId,
          quantity: event.quantity,
          userId: event.userId,
        );

        emit(LoadedFarmerInputs(inputs: inputs));
      } on AppException catch (e) {
        emit(
          FarmerInputStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerInputStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<UpdateFarmerInputEvent>((event, emit) async {
      emit(FarmerInputStateLoading());
      try {
        final token = await getAuthToken();

        final inputs = await inputRepository.updateFarmerInput(
          token: token!,
          userId: event.userId,
          inputId: event.inputId,
          payback: event.payback,
          received: event.received,
        );

        emit(LoadedFarmerInputs(inputs: inputs));
      } on AppException catch (e) {
        emit(
          FarmerInputStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerInputStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<SearchFarmerInputs>((event, emit) async {
      emit(FarmerInputStateSearchLoading());
      try {
        final token = await getAuthToken();
        final inputs = await inputRepository.getFarmerInputs(
          token: token!,
          userId: event.userId,
        );

        final filtered = inputs
            .where((input) => input.input.name
                .toLowerCase()
                .contains(event.query.toLowerCase()))
            .toList();

        emit(
          LoadedFarmerInputs(inputs: filtered),
        );
      } on AppException catch (e) {
        emit(
          FarmerInputStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerInputStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });
  }
}
