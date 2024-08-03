part of 'authentication_bloc.dart';

sealed class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationEventInitialize extends AuthenticationEvent {}

class AuthenticationEventRegisterUser implements AuthenticationEvent {
  final String phone;
  final String fcmToken;

  const AuthenticationEventRegisterUser({
    required this.phone,
    required this.fcmToken,
  });

  @override
  List<Object> get props => [phone, fcmToken];

  @override
  bool? get stringify => true;
}

class AuthenticationEventLoginUser extends AuthenticationEvent {
  final String email;
  final String password;

  const AuthenticationEventLoginUser({
    required this.email,
    required this.password,
  });
}

class AuthenticationEventSentVerifyCode extends AuthenticationEvent {
  final String phone;

  const AuthenticationEventSentVerifyCode({
    required this.phone,
  });
}

class AuthenticationEventVerifyCode extends AuthenticationEvent {
  final String phone;
  final String fcmToken;
  final String code;

  const AuthenticationEventVerifyCode({
    required this.phone,
    required this.fcmToken,
    required this.code,
  });
}

class AuthenticationEventForgot extends AuthenticationEvent {
  final String email;

  const AuthenticationEventForgot({
    required this.email,
  });
}

class AuthenticationEventResetCodeConfirm extends AuthenticationEvent {
  final String email;
  final String code;

  const AuthenticationEventResetCodeConfirm({
    required this.email,
    required this.code,
  });
}

class AuthenticationEventResetPassword extends AuthenticationEvent {
  final String token;
  final String password;

  const AuthenticationEventResetPassword({
    required this.token,
    required this.password,
  });
}

class AuthenticationEventLogoutUser extends AuthenticationEvent {}
