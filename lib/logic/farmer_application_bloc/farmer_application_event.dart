part of 'farmer_application_bloc.dart';

abstract class FarmerApplicationEvent extends Equatable {
  const FarmerApplicationEvent();

  @override
  List<Object> get props => [];
}

class LoadApplications extends FarmerApplicationEvent {}

class SearchFarmerApplications extends FarmerApplicationEvent {
  final String userId;
  final String query;
  const SearchFarmerApplications({
    required this.userId,
    required this.query,
  });
}

class LoadFarmerApplications extends FarmerApplicationEvent {
  final String userId;
  const LoadFarmerApplications({
    required this.userId,
  });
}

class AcceptFarmerApplicationEvent extends FarmerApplicationEvent {
  final double quantity;
  final String inputId;
  final String applicationId;
  final String userId;

  const AcceptFarmerApplicationEvent({
    required this.quantity,
    required this.inputId,
    required this.applicationId,
    required this.userId,
  });
}

class RejectFarmerApplicationEvent extends FarmerApplicationEvent {
  final String applicationId;

  const RejectFarmerApplicationEvent({
    required this.applicationId,
  });
}

class AddFarmerApplicationEvent extends FarmerApplicationEvent {
  final double quantity;
  final String message;
  final String inputId;
  final String userId;

  const AddFarmerApplicationEvent({
    required this.quantity,
    required this.message,
    required this.inputId,
    required this.userId,
  });
}

class UpdateFarmerApplicationEvent extends FarmerApplicationEvent {
  final String userId;
  final double payback;
  final String inputId;
  final bool received;

  const UpdateFarmerApplicationEvent({
    required this.userId,
    required this.payback,
    required this.inputId,
    required this.received,
  });
}
