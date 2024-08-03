import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/storage.dart';
import 'package:tisha_app/data/models/auth_error.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/authentication/authentication_repository.dart';

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationRepository authenticationRepository;

  AuthenticationBloc({
    required this.authenticationRepository,
  }) : super(AuthenticationStateUserNotLoggedIn()) {
    on<AuthenticationEventLogoutUser>((event, emit) {
      deleteAuthToken();
      deleteUserId();
      emit(const AuthenticationStateUserLoggedOut());
    });

    //initialize app
    on<AuthenticationEventInitialize>((event, emit) async {
      emit(AuthenticationStateIsInSplashPage());

      try {
        final token = await getAuthToken();

        if (token != null) {
          final loggedUser = await authenticationRepository.authenticate(
            token: token,
          );

          emit(
            AuthenticationStateUserLoggedIn(
              user: loggedUser,
            ),
          );
        } else {
          emit(AuthenticationStateUserNotLoggedIn());
        }
      } on AppException catch (e) {
        if (e.message == "Unauthorized") {
          deleteAuthToken();
          deleteUserId();
          emit(const AuthenticationStateUserLoggedOut());
        } else {
          emit(
            AuthenticationStateError(
              authError: AuthError.from(e),
            ),
          );
        }
      } on TimeoutException catch (e) {
        emit(
          AuthenticationStateError(
            authError: AuthError.from(
              AppException(
                message: e.message,
              ),
            ),
          ),
        );
      }
    });

    on<AuthenticationEventRegisterUser>((event, emit) async {
      emit(
        AuthenticationStateLoading(),
      );

      try {
        final response = await authenticationRepository.register(
          phone: event.phone,
          fcmToken: event.fcmToken,
        );

        emit(
          AuthenticationStateCodeSent(
            message: response["message"],
            phone: response["phone"],
          ),
        );
      } on AppException catch (e) {
        emit(
          AuthenticationStateError(
            authError: AuthError.from(e),
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          AuthenticationStateError(
            authError: AuthError.from(
              AppException(
                message: e.message,
              ),
            ),
          ),
        );
      }
    });

    on<AuthenticationEventLoginUser>((event, emit) async {
      emit(
        AuthenticationStateLoading(),
      );

      final email = event.email;
      final password = event.password;

      try {
        final authToken = await authenticationRepository.login(
          email: email,
          password: password,
        );

        saveAuthToken(authToken);

        final loggedUser = await authenticationRepository.authenticate(
          token: authToken,
        );
        emit(
          AuthenticationStateUserLoggedIn(
            user: loggedUser,
          ),
        );
      } on AppException catch (e) {
        emit(
          AuthenticationStateError(
            authError: AuthError.from(e),
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          AuthenticationStateError(
            authError: AuthError.from(
              AppException(
                message: e.message,
              ),
            ),
          ),
        );
      }
    });
  }
}
