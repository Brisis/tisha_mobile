import 'package:flutter/foundation.dart' show immutable;
import 'package:tisha_app/core/config/exception_handlers.dart';

const Map<String, AuthError> authErrorMapping = {
  "user-not-found": AuthErrorUserNotFound(),
  "incorrect-email-or-password": AuthErrorInvalidCreds(),
  "invalid-email": AuthErrorInvalidEmail(),
  "operation-not-allowed": AuthErrorOperationNotAllowed(),
  "email-already-in-use": AuthErrorEmailAlreadyInUse(),
  "requires-recent-login": AuthErrorRequiresRecentLogin(),
  "no-current-user": AuthErrorNoCurrentUser(),
};

@immutable
abstract class AuthError {
  final String dialogTitle;
  final String dialogText;

  const AuthError({
    required this.dialogTitle,
    required this.dialogText,
  });

  factory AuthError.from(AppException exception) =>
      authErrorMapping[exception.message.toString().toLowerCase().trim()] ??
      AuthErrorUnknown(message: exception.message.toString());
}

@immutable
class AuthErrorUnknown extends AuthError {
  const AuthErrorUnknown({required String message})
      : super(
          dialogTitle: "Authentication error",
          dialogText: message,
        );
}

//  no-current-user

@immutable
class AuthErrorNoCurrentUser extends AuthError {
  const AuthErrorNoCurrentUser()
      : super(
          dialogTitle: "No current user!",
          dialogText: "No current user with this information was found!",
        );
}

// requires-recent-login
@immutable
class AuthErrorRequiresRecentLogin extends AuthError {
  const AuthErrorRequiresRecentLogin()
      : super(
          dialogTitle: "Requires recent login",
          dialogText:
              "You need to logout and log back in again in order to perform this operation.",
        );
}

//invalid creds
@immutable
class AuthErrorInvalidCreds extends AuthError {
  const AuthErrorInvalidCreds()
      : super(
          dialogTitle: "Incorrect Email or Password",
          dialogText: "Incorrect Email or Password",
        );
}

//not-allowed
@immutable
class AuthErrorOperationNotAllowed extends AuthError {
  const AuthErrorOperationNotAllowed()
      : super(
          dialogTitle: "Operation not allowed",
          dialogText:
              "You cannot register using this method at this moment in time!",
        );
}

//user-not-found
@immutable
class AuthErrorUserNotFound extends AuthError {
  const AuthErrorUserNotFound()
      : super(
          dialogTitle: "User not found",
          dialogText: "The given user was not found on the server!",
        );
}

//invalid-email
@immutable
class AuthErrorInvalidEmail extends AuthError {
  const AuthErrorInvalidEmail()
      : super(
          dialogTitle: "Invalid email",
          dialogText: "Please double check your email and try again!",
        );
}

//email-already-in-use
@immutable
class AuthErrorEmailAlreadyInUse extends AuthError {
  const AuthErrorEmailAlreadyInUse()
      : super(
          dialogTitle: "Email already in use",
          dialogText: "Please choose another email to register with!",
        );
}
