import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/storage.dart';
import 'package:tisha_app/data/models/feedback.dart';
import 'package:tisha_app/data/repositories/feedback/feedback_repository.dart';

part 'feedback_event.dart';
part 'feedback_state.dart';

class FeedbackBloc extends Bloc<FeedbackEvent, FeedbackState> {
  final FeedbackRepository feedbackRepository;
  FeedbackBloc({
    required this.feedbackRepository,
  }) : super(FeedbackStateInitial()) {
    on<LoadFeedbacks>((event, emit) async {
      emit(FeedbackStateLoading());
      try {
        final feedbacks = await feedbackRepository.getFeedbacks();

        emit(LoadedFeedbacks(feedbacks: feedbacks));
      } on AppException catch (e) {
        emit(
          FeedbackStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FeedbackStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<AddFeedbackEvent>((event, emit) async {
      emit(FeedbackStateLoading());
      try {
        final token = await getAuthToken();

        final feedbacks = await feedbackRepository.addFeedback(
          token: token!,
          userId: event.userId,
          message: event.message,
        );

        emit(LoadedFeedbacks(feedbacks: feedbacks));
      } on AppException catch (e) {
        emit(
          FeedbackStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          FeedbackStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });
  }
}
