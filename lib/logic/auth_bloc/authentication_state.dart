part of 'authentication_bloc.dart';

sealed class AuthenticationState extends Equatable {
  const AuthenticationState();

  @override
  List<Object> get props => [];
}

class AuthenticationInitialState extends AuthenticationState {}

class AuthenticationStateLoading extends AuthenticationState {}

class AuthenticationStateIsInSplashPage extends AuthenticationState {}

class AuthenticationStateUserNotLoggedIn extends AuthenticationState {}

class AuthenticationStateUserRegistered extends AuthenticationState {}

class AuthenticationStateCodeSent extends AuthenticationState {
  final String message;
  final String phone;

  const AuthenticationStateCodeSent({
    required this.message,
    required this.phone,
  });

  @override
  List<Object> get props => [message];
}

class AuthenticationStateUserLoggedIn extends AuthenticationState {
  final User user;

  const AuthenticationStateUserLoggedIn({
    required this.user,
  });

  @override
  List<Object> get props => [user];
}

class AuthenticationStateError extends AuthenticationState {
  final AuthError? authError;
  const AuthenticationStateError({
    this.authError,
  });
}

class AuthenticationStateUserLoggedOut extends AuthenticationState {
  final AuthError? authError;

  const AuthenticationStateUserLoggedOut({
    this.authError,
  });
}
