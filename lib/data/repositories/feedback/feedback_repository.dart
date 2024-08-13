import 'package:tisha_app/data/models/feedback.dart';
import 'package:tisha_app/data/repositories/feedback/feedback_provider.dart';

class FeedbackRepository {
  final FeedbackProvider feedbackProvider;
  const FeedbackRepository({required this.feedbackProvider});

  Future<List<Feedback>> getFeedbacks() async {
    final response = await feedbackProvider.getFeedbacks();

    return (response as List<dynamic>)
        .map(
          (i) => Feedback.fromJson(i),
        )
        .toList();
  }

  Future<List<Feedback>> addFeedback({
    required String token,
    required String userId,
    required String message,
  }) async {
    final response = await feedbackProvider.addFeedback(
      token: token,
      userId: userId,
      message: message,
    );

    return (response as List<dynamic>)
        .map(
          (i) => Feedback.fromJson(i),
        )
        .toList();
  }
}
