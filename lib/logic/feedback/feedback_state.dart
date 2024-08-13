part of 'feedback_bloc.dart';

abstract class FeedbackState extends Equatable {
  const FeedbackState();

  @override
  List<Object> get props => [];
}

final class FeedbackStateInitial extends FeedbackState {}

class FeedbackStateLoading extends FeedbackState {}

class LoadedFeedbacks extends FeedbackState {
  final List<Feedback> feedbacks;
  const LoadedFeedbacks({
    required this.feedbacks,
  });

  @override
  List<Object> get props => [feedbacks];

  @override
  bool? get stringify => true;
}

class FeedbackStateError extends FeedbackState {
  final AppException? message;
  const FeedbackStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

// Extract user from UserState
extension GetFeedbacks on FeedbackState {
  List<Feedback> get feedbacks {
    final cls = this;
    if (cls is LoadedFeedbacks) {
      return cls.feedbacks;
    } else {
      return [];
    }
  }
}
