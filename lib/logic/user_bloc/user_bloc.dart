import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/storage.dart';
import 'package:tisha_app/data/models/farmer_input.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/user/user_repository.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserRepository userRepository;

  UserBloc({
    required this.userRepository,
  }) : super(UserStateLoading()) {
    on<LoadUser>((event, emit) async {
      emit(LoadedUser(user: event.user));
    });

    on<UserEventUpdateDetails>((event, emit) async {
      emit(
        UserStateLoading(),
      );

      try {
        final token = await getAuthToken();

        final userResponse = await userRepository.updateUserDetails(
          token: token!,
          user: event.user,
        );

        emit(UserStateUpdated());

        emit(LoadedUser(user: userResponse));
      } on AppException catch (e) {
        emit(
          UserStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          UserStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<UserEventUpdateInputs>((event, emit) async {
      emit(
        UserStateLoading(),
      );

      try {
        final token = await getAuthToken();

        final userResponse = await userRepository.updateUserInputs(
          token: token!,
          id: event.id,
          inputs: event.inputs,
        );

        emit(UserStateUpdated());

        emit(LoadedUser(user: userResponse));
      } on AppException catch (e) {
        emit(
          UserStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          UserStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });
  }
}
