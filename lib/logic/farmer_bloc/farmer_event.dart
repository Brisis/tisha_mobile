part of 'farmer_bloc.dart';

abstract class FarmerEvent extends Equatable {
  const FarmerEvent();
  @override
  List<Object> get props => [];
}

class LoadFarmer extends FarmerEvent {
  final String id;

  const LoadFarmer({
    required this.id,
  });
}

class SearchFarmer extends FarmerEvent {
  final String userId;
  final String? query;
  final String? locationId;

  const SearchFarmer({
    this.query,
    this.locationId,
    required this.userId,
  });
}

class LoadFarmers extends FarmerEvent {
  final String userId;

  const LoadFarmers({
    required this.userId,
  });
}
