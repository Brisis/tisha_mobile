import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/storage.dart';
import 'package:tisha_app/data/models/input_application.dart';
import 'package:tisha_app/data/repositories/application/application_repository.dart';

part 'farmer_application_event.dart';
part 'farmer_application_state.dart';

class FarmerApplicationBloc
    extends Bloc<FarmerApplicationEvent, FarmerApplicationState> {
  final ApplicationRepository applicationRepository;
  FarmerApplicationBloc({
    required this.applicationRepository,
  }) : super(FarmerApplicationStateInitial()) {
    on<LoadApplications>((event, emit) async {
      emit(FarmerApplicationStateLoading());
      try {
        final applications = await applicationRepository.getApplications();

        emit(LoadedApplications(applications: applications));
      } on AppException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<LoadFarmerApplications>((event, emit) async {
      emit(FarmerApplicationStateLoading());
      try {
        final token = await getAuthToken();
        final applications = await applicationRepository.getFarmerApplications(
          token: token!,
          userId: event.userId,
        );

        emit(LoadedFarmerApplications(applications: applications));
      } on AppException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<AddFarmerApplicationEvent>((event, emit) async {
      emit(FarmerApplicationStateLoading());
      try {
        final token = await getAuthToken();

        final applications = await applicationRepository.addApplication(
          token: token!,
          inputId: event.inputId,
          message: event.message,
          quantity: event.quantity,
          userId: event.userId,
        );

        emit(LoadedFarmerApplications(applications: applications));
      } on AppException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<UpdateFarmerApplicationEvent>((event, emit) async {
      emit(FarmerApplicationStateLoading());
      try {
        final token = await getAuthToken();

        final applications =
            await applicationRepository.updateFarmerApplication(
          token: token!,
          userId: event.userId,
          inputId: event.inputId,
          payback: event.payback,
          received: event.received,
        );

        emit(LoadedFarmerApplications(applications: applications));
      } on AppException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<SearchFarmerApplications>((event, emit) async {
      emit(FarmerApplicationStateSearchLoading());
      try {
        final token = await getAuthToken();
        final applications = await applicationRepository.getFarmerApplications(
          token: token!,
          userId: event.userId,
        );

        final filtered = applications
            .where((input) => input.input.name
                .toLowerCase()
                .contains(event.query.toLowerCase()))
            .toList();

        emit(
          LoadedFarmerApplications(applications: filtered),
        );
      } on AppException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerApplicationStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });
  }
}
