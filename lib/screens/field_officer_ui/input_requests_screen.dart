import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/farmer_application_bloc/farmer_application_bloc.dart';
import 'package:tisha_app/screens/admin_ui/farmer_application_screen.dart';
import 'package:tisha_app/screens/field_officer_ui/field_officer_home_screen.dart';
import 'package:tisha_app/screens/widgets/application_item.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/theme/colors.dart';

class InputRequestsScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const InputRequestsScreen(),
    );
  }

  const InputRequestsScreen({super.key});

  @override
  State<InputRequestsScreen> createState() => _InputRequestsScreenState();
}

class _InputRequestsScreenState extends State<InputRequestsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<FarmerApplicationBloc>().add(LoadApplications());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        leading: IconButton(
          onPressed: () =>
              Navigator.push(context, FieldOfficerHomeScreen.route()),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          "Input Application Requests",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<FarmerApplicationBloc, FarmerApplicationState>(
          builder: (context, state) {
            if (state is LoadedApplications) {
              final applications = state.applications.reversed.toList();
              return applications.isNotEmpty
                  ? ListView.builder(
                      itemCount: applications.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ApplicationItem(
                            farmer: applications[index].user,
                            application: applications[index],
                            onTap: () {
                              Navigator.push(
                                  context,
                                  FarmerApplicationScreen.route(
                                    farmer: applications[index].user,
                                    application: applications[index],
                                  ));
                            },
                          ),
                        );
                      })
                  : Center(
                      child: Text(
                        "0 Found",
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
                context.read<FarmerApplicationBloc>().add(LoadApplications());
              },
            );
          },
        ),
      ),
    );
  }
}
