import 'package:tisha_app/data/models/location.dart';
import 'package:tisha_app/data/repositories/location/location_provider.dart';

class LocationRepository {
  final LocationProvider locationProvider;
  const LocationRepository({required this.locationProvider});

  Future<List<Location>> getLocations() async {
    final response = await locationProvider.getLocations();

    return (response as List<dynamic>)
        .map(
          (i) => Location.fromJson(i),
        )
        .toList();
  }

  Future<List<Location>> addLocation({
    required String token,
    required String name,
    required String city,
  }) async {
    final response = await locationProvider.addLocation(
      token: token,
      name: name,
      city: city,
    );

    return (response as List<dynamic>)
        .map(
          (i) => Location.fromJson(i),
        )
        .toList();
  }
}
