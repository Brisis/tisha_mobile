part of 'feedback_bloc.dart';

abstract class FeedbackEvent extends Equatable {
  const FeedbackEvent();

  @override
  List<Object> get props => [];
}

class LoadFeedbacks extends FeedbackEvent {}

class AddFeedbackEvent extends FeedbackEvent {
  final String userId;
  final String message;

  const AddFeedbackEvent({
    required this.userId,
    required this.message,
  });
}
