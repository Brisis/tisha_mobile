part of 'farmer_bloc.dart';

abstract class FarmerState extends Equatable {
  const FarmerState();

  @override
  List<Object> get props => [];
}

final class FarmerStateInitial extends FarmerState {}

class FarmerStateLoading extends FarmerState {}

class FarmerStateSearchLoading extends FarmerState {}

class LoadedFarmer extends FarmerState {
  final User farmer;
  const LoadedFarmer({
    required this.farmer,
  });

  @override
  List<Object> get props => [farmer];

  @override
  bool? get stringify => true;
}

class LoadedFarmers extends FarmerState {
  final List<User> farmers;
  const LoadedFarmers({
    required this.farmers,
  });

  @override
  List<Object> get props => [farmers];

  @override
  bool? get stringify => true;
}

class LoadedSearchFarmers extends FarmerState {
  final List<User> farmers;
  const LoadedSearchFarmers({
    required this.farmers,
  });

  @override
  List<Object> get props => [farmers];

  @override
  bool? get stringify => true;
}

class FarmerStateError extends FarmerState {
  final AppException? message;
  const FarmerStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

extension GetFarmers on FarmerState {
  List<User> get farmers {
    final cls = this;
    if (cls is LoadedFarmers) {
      return cls.farmers;
    } else {
      return [];
    }
  }
}

extension GetFarmer on FarmerState {
  User? get farmer {
    final cls = this;
    if (cls is LoadedFarmer) {
      return cls.farmer;
    } else {
      return null;
    }
  }
}
