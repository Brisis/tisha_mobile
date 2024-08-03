import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/data/models/location.dart';
import 'package:tisha_app/data/repositories/location/location_repository.dart';

part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationRepository locationRepository;
  LocationBloc({
    required this.locationRepository,
  }) : super(LocationStateInitial()) {
    on<LoadLocations>((event, emit) async {
      emit(LocationStateLoading());
      try {
        final locations = await locationRepository.getLocations();

        emit(LoadedLocations(locations: locations));
      } on AppException catch (e) {
        emit(
          LocationStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          LocationStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });
  }
}
