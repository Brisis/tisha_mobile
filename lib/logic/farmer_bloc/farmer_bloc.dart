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

    on<AddFarmerEvent>((event, emit) async {
      emit(FarmerStateLoading());
      try {
        final token = await getAuthToken();

        final farmers = await farmerRepository.addFarmer(
          token: token!,
          name: event.name,
          surname: event.surname,
          dob: event.dob,
          age: event.dob != null
              ? (DateTime.now().year - event.dob!.year)
              : null,
          gender: event.gender,
          phone: event.phone,
          address: event.address,
          nationalId: event.nationalId,
          landOwnership: event.landOwnership,
          farmerType: event.farmerType,
          cropType: event.cropType,
          livestockType: event.livestockType,
          livestockNumber: event.livestockNumber,
          farmSize: event.farmSize,
          locationId: event.locationId,
          coordinates: event.coordinates,
          email: event.email,
          password: event.password,
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
            query: event.query,
          );
          farmers = farmers
              .where((person) => person.locationId == event.locationId)
              .toList();
        } else if (event.locationId != null) {
          farmers = await farmerRepository.getFarmers(
            token: token!,
          );
          farmers = farmers
              .where((person) => person.locationId == event.locationId)
              .toList();
        } else {
          farmers = await farmerRepository.getFarmers(
            token: token!,
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
