import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/feedback/feedback_bloc.dart';
import 'package:tisha_app/screens/add_feedback_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/feedback_item.dart';
import 'package:tisha_app/theme/colors.dart';

class FeedbackForumScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const FeedbackForumScreen(),
    );
  }

  const FeedbackForumScreen({super.key});

  @override
  State<FeedbackForumScreen> createState() => _FeedbackForumScreenState();
}

class _FeedbackForumScreenState extends State<FeedbackForumScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FeedbackBloc>().add(LoadFeedbacks());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Farmer's Forum",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<FeedbackBloc, FeedbackState>(
          builder: (context, state) {
            if (state is LoadedFeedbacks) {
              final feedbacks = state.feedbacks;

              return feedbacks.isNotEmpty
                  ? ListView.builder(
                      itemCount: feedbacks.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FeedbackItem(
                            farmer: feedbacks[index].user,
                            message: feedbacks[index].message,
                            date: feedbacks[index].createdAt,
                            onTap: () {},
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                        "0 posts found",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
            }

            if (state is FeedbackStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              label: "Reload",
              onPressed: () {
                context.read<FeedbackBloc>().add(LoadFeedbacks());
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.kPrimaryColor,
        onPressed: () {
          Navigator.push(context, AddFeedbackScreen.route());
        },
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: CustomColors.kWhiteTextColor,
        ),
      ),
    );
  }
}
