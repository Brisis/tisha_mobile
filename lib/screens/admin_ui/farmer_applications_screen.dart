import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/farmer_application_bloc/farmer_application_bloc.dart';
import 'package:tisha_app/screens/widgets/application_item.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/theme/colors.dart';

class FarmerApplicationsScreen extends StatelessWidget {
  static Route route({required String userId}) {
    return MaterialPageRoute(
      builder: (context) => FarmerApplicationsScreen(
        userId: userId,
      ),
    );
  }

  final String userId;

  const FarmerApplicationsScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Input Applications",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<FarmerApplicationBloc, FarmerApplicationState>(
          builder: (context, state) {
            if (state is LoadedFarmerApplications) {
              final applications = state.applications.reversed.toList();
              return applications.isNotEmpty
                  ? ListView.builder(
                      itemCount: applications.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ApplicationItem(
                            farmer: applications[index].user,
                            input: applications[index].input,
                            date: applications[index].createdAt,
                            onTap: () {},
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                        "Not Found",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    );
            }

            if (state is FarmerApplicationStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              label: "Reload",
              onPressed: () {
                context.read<FarmerApplicationBloc>().add(
                      LoadFarmerApplications(userId: userId),
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
