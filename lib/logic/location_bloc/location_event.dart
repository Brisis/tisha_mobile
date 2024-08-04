part of 'location_bloc.dart';

abstract class LocationEvent extends Equatable {
  const LocationEvent();

  @override
  List<Object> get props => [];
}

class LoadLocations extends LocationEvent {}

class AddLocationEvent extends LocationEvent {
  final String name;
  final String city;

  const AddLocationEvent({
    required this.name,
    required this.city,
  });
}
