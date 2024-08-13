part of 'farmer_application_bloc.dart';

abstract class FarmerApplicationState extends Equatable {
  const FarmerApplicationState();

  @override
  List<Object> get props => [];
}

final class FarmerApplicationStateInitial extends FarmerApplicationState {}

class FarmerApplicationStateSearchLoading extends FarmerApplicationState {}

class FarmerApplicationStateLoading extends FarmerApplicationState {}

class LoadedApplications extends FarmerApplicationState {
  final List<InputApplication> applications;
  const LoadedApplications({
    required this.applications,
  });

  @override
  List<Object> get props => [applications];

  @override
  bool? get stringify => true;
}

class LoadedFarmerApplications extends FarmerApplicationState {
  final List<InputApplication> applications;
  const LoadedFarmerApplications({
    required this.applications,
  });

  @override
  List<Object> get props => [applications];

  @override
  bool? get stringify => true;
}

class FarmerApplicationStateError extends FarmerApplicationState {
  final AppException? message;
  const FarmerApplicationStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

extension GetApplications on FarmerApplicationState {
  List<InputApplication> get applications {
    final cls = this;
    if (cls is LoadedApplications) {
      return cls.applications;
    } else {
      return [];
    }
  }
}
