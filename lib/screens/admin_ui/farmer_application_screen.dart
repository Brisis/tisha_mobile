import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/input_application.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/logic/farmer_application_bloc/farmer_application_bloc.dart';
import 'package:tisha_app/screens/widgets/application_view_item.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class FarmerApplicationScreen extends StatefulWidget {
  static Route route({
    required User farmer,
    required InputApplication application,
  }) {
    return MaterialPageRoute(
      builder: (context) => FarmerApplicationScreen(
        farmer: farmer,
        application: application,
      ),
    );
  }

  final User farmer;
  final InputApplication application;
  const FarmerApplicationScreen({
    super.key,
    required this.farmer,
    required this.application,
  });

  @override
  State<FarmerApplicationScreen> createState() =>
      _FarmerApplicationScreenState();
}

class _FarmerApplicationScreenState extends State<FarmerApplicationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _quantityController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Assign Input",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: BlocListener<FarmerApplicationBloc, FarmerApplicationState>(
        listener: (context, state) {
          if (state is LoadedApplications) {
            // context.read<FarmerBloc>().add(LoadFarmer(id: widget.farmer.id));
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                Text(
                  "Application Details",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: CustomColors.kBoldTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CustomSpaces.verticalSpace(),
                ApplicationViewItem(
                  application: widget.application,
                  farmer: widget.farmer,
                ),
                CustomSpaces.verticalSpace(height: 15),
                Text(
                  "Message: ${widget.application.message}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                CustomSpaces.verticalSpace(height: 15),
                Text(
                  "${widget.application.input.name} left: ${widget.application.input.quantity}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                CustomSpaces.verticalSpace(height: 15),
                Text(
                  "Quantity Requested: ${widget.application.quantity}",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                CustomSpaces.verticalSpace(height: 30),
                widget.application.accepted
                    ? Text(
                        "Application Completed",
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: CustomColors.kSuccessColor,
                              fontWeight: FontWeight.bold,
                            ),
                      )
                    : Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "To give",
                            style:
                                Theme.of(context).textTheme.bodyLarge!.copyWith(
                                      color: CustomColors.kBoldTextColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          CustomSpaces.verticalSpace(),
                          CustomTextField(
                            label: "Quantity",
                            keyboardType: TextInputType.number,
                            controller: _quantityController,
                          ),
                          BlocBuilder<FarmerApplicationBloc,
                              FarmerApplicationState>(
                            builder: (context, state) {
                              if (state is FarmerApplicationStateError) {
                                return Padding(
                                  padding: const EdgeInsets.only(top: 30.0),
                                  child: Text(
                                    state.message!.message!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .copyWith(
                                          color: CustomColors.kWarningColor,
                                        ),
                                    textAlign: TextAlign.center,
                                  ),
                                );
                              }
                              return const SizedBox.shrink();
                            },
                          ),
                          CustomSpaces.verticalSpace(height: 30),
                          BlocBuilder<FarmerApplicationBloc,
                              FarmerApplicationState>(
                            builder: (context, state) {
                              if (state is FarmerApplicationStateLoading) {
                                return const CustomButton();
                              }
                              return CustomButton(
                                label: "Accept",
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    context.read<FarmerApplicationBloc>().add(
                                          AcceptFarmerApplicationEvent(
                                            quantity: double.parse(
                                                _quantityController.text
                                                    .trim()),
                                            inputId:
                                                widget.application.input.id,
                                            userId: widget.application.user.id,
                                            applicationId:
                                                widget.application.id,
                                          ),
                                        );
                                  }
                                },
                              );
                            },
                          ),
                        ],
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
