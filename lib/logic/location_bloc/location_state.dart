part of 'location_bloc.dart';

abstract class LocationState extends Equatable {
  const LocationState();

  @override
  List<Object> get props => [];
}

final class LocationStateInitial extends LocationState {}

class LocationStateLoading extends LocationState {}

class LoadedLocations extends LocationState {
  final List<Location> locations;
  const LoadedLocations({
    required this.locations,
  });

  @override
  List<Object> get props => [locations];

  @override
  bool? get stringify => true;
}

class LocationStateError extends LocationState {
  final AppException? message;
  const LocationStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

// Extract user from UserState
extension GetLocations on LocationState {
  List<Location> get locations {
    final cls = this;
    if (cls is LoadedLocations) {
      return cls.locations;
    } else {
      return [];
    }
  }
}
