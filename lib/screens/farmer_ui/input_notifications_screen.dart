import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/screens/farmer_ui/input_application_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/input_item.dart';
import 'package:tisha_app/theme/colors.dart';

class InputNotificationsScreen extends StatefulWidget {
  static Route route({required User farmer}) {
    return MaterialPageRoute(
      builder: (context) => InputNotificationsScreen(
        farmer: farmer,
      ),
    );
  }

  final User farmer;

  const InputNotificationsScreen({
    super.key,
    required this.farmer,
  });

  @override
  State<InputNotificationsScreen> createState() =>
      _InputNotificationsScreenState();
}

class _InputNotificationsScreenState extends State<InputNotificationsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<InputBloc>().add(LoadInputs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Apply for Inputs",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<InputBloc, InputState>(
          builder: (context, state) {
            if (state is LoadedInputs) {
              final inputs = state.inputs.reversed.toList();
              return inputs.isNotEmpty
                  ? ListView.builder(
                      itemCount: inputs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InputItem(
                            name: inputs[index].name,
                            quantity: inputs[index].quantity,
                            unit: inputs[index].unit,
                            date: inputs[index].createdAt,
                            onTap: () {
                              if (widget.farmer.locationId ==
                                  inputs[index].locationId) {
                                Navigator.push(
                                  context,
                                  InputApplicationScreen.route(
                                    loggedUser: widget.farmer,
                                    input: inputs[index],
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        "This input is for farmers outside of your location"),
                                  ),
                                );
                              }
                            },
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

            if (state is InputStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              label: "Reload",
              onPressed: () {
                context.read<InputBloc>().add(LoadInputs());
              },
            );
          },
        ),
      ),
    );
  }
}
