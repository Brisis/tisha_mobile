import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/storage.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/farmer/farmer_repository.dart';

part 'farmer_event.dart';
part 'farmer_state.dart';

class FarmerBloc extends Bloc<FarmerEvent, FarmerState> {
  final FarmerRepository farmerRepository;
  FarmerBloc({
    required this.farmerRepository,
  }) : super(FarmerStateInitial()) {
    on<LoadFarmers>((event, emit) async {
      emit(FarmerStateLoading());
      try {
        final token = await getAuthToken();

        final farmers = await farmerRepository.getFarmers(
          token: token!,
          userId: event.userId,
        );

        emit(LoadedFarmers(farmers: farmers));
      } on AppException catch (e) {
        emit(
          FarmerStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<SearchFarmer>((event, emit) async {
      emit(FarmerStateSearchLoading());
      try {
        final token = await getAuthToken();

        List<User> farmers = [];

        if (event.query != null && event.locationId != null) {
          farmers = await farmerRepository.getFarmers(
            token: token!,
            userId: event.userId,
            query: event.query,
          );
          farmers = farmers
              .where((person) => person.locationId == event.locationId)
              .toList();
        } else if (event.locationId != null) {
          farmers = await farmerRepository.getFarmers(
            token: token!,
            userId: event.userId,
          );
          farmers = farmers
              .where((person) => person.locationId == event.locationId)
              .toList();
        } else {
          farmers = await farmerRepository.getFarmers(
            token: token!,
            userId: event.userId,
            query: event.query,
          );
        }

        emit(LoadedSearchFarmers(farmers: farmers));
      } on AppException catch (e) {
        emit(
          FarmerStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<LoadFarmer>((event, emit) async {
      emit(FarmerStateLoading());
      try {
        final token = await getAuthToken();

        final farmer = await farmerRepository.getFarmer(
          token: token!,
          id: event.id,
        );

        emit(LoadedFarmer(farmer: farmer));
      } on AppException catch (e) {
        emit(
          FarmerStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FarmerStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });
  }
}
