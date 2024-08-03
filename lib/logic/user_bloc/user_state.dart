part of 'user_bloc.dart';

abstract class UserState extends Equatable {
  const UserState();

  @override
  List<Object> get props => [];
}

class UserStateLoading extends UserState {}

class UserStateAvatarLoading extends UserState {}

class UserStateUserRegistered extends UserState {}

class UserStateUpdated extends UserState {}

class LoadedUser extends UserState {
  final User user;

  const LoadedUser({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class UserStateError extends UserState {
  final AppException? message;
  const UserStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

// Extract user from UserState
extension GetUser on UserState {
  User? get user {
    final cls = this;
    if (cls is LoadedUser) {
      return cls.user;
    } else {
      return null;
    }
  }
}
