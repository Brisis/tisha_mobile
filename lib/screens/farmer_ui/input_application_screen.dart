import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/logic/farmer_application_bloc/farmer_application_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/input_item.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class InputApplicationScreen extends StatefulWidget {
  static Route route({
    required String userId,
    required Input input,
  }) {
    return MaterialPageRoute(
      builder: (context) => InputApplicationScreen(
        userId: userId,
        input: input,
      ),
    );
  }

  final String userId;
  final Input input;
  const InputApplicationScreen({
    super.key,
    required this.userId,
    required this.input,
  });

  @override
  State<InputApplicationScreen> createState() => _InputApplicationScreenState();
}

class _InputApplicationScreenState extends State<InputApplicationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Apply for Input",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: BlocListener<FarmerApplicationBloc, FarmerApplicationState>(
        listener: (context, state) {
          if (state is LoadedFarmerApplications) {
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                InputItem(
                  name: widget.input.name,
                  quantity: widget.input.quantity,
                  unit: widget.input.unit,
                  date: widget.input.createdAt,
                ),
                CustomSpaces.verticalSpace(height: 30),
                Text(
                  "Application Details",
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: CustomColors.kBoldTextColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Reason",
                  controller: _messageController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Reason is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Quantity",
                  keyboardType: TextInputType.number,
                  controller: _quantityController,
                ),
                BlocBuilder<FarmerApplicationBloc, FarmerApplicationState>(
                  builder: (context, state) {
                    if (state is FarmerApplicationStateError) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 30.0),
                        child: Text(
                          state.message!.message!,
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
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
                BlocBuilder<FarmerApplicationBloc, FarmerApplicationState>(
                  builder: (context, state) {
                    if (state is FarmerApplicationStateLoading) {
                      return const CustomButton();
                    }
                    return CustomButton(
                      label: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<FarmerApplicationBloc>().add(
                                AddFarmerApplicationEvent(
                                  quantity: double.parse(
                                      _quantityController.text.trim()),
                                  message: _messageController.text.trim(),
                                  inputId: widget.input.id,
                                  userId: widget.userId,
                                ),
                              );
                        }
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
