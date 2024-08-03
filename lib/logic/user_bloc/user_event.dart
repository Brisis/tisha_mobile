part of 'user_bloc.dart';

abstract class UserEvent extends Equatable {
  const UserEvent();

  @override
  List<Object> get props => [];
}

class LoadUser extends UserEvent {
  final User user;
  const LoadUser({
    required this.user,
  });
}

class UserEventUpdateDetails implements UserEvent {
  final User user;

  const UserEventUpdateDetails({
    required this.user,
  });

  @override
  List<Object> get props => [user];

  @override
  bool? get stringify => true;
}

class UserEventUpdateInputs implements UserEvent {
  final String id;
  final List<FarmerInput> inputs;

  const UserEventUpdateInputs({
    required this.id,
    required this.inputs,
  });

  @override
  List<Object> get props => [id, inputs];

  @override
  bool? get stringify => true;
}

class UserEventLogoutUser extends UserEvent {}
