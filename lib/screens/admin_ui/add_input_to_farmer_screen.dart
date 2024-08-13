import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/logic/farmer_bloc/farmer_bloc.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/input_item.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AddInputToFarmerScreen extends StatefulWidget {
  static Route route({
    required String userId,
    required Input input,
  }) {
    return MaterialPageRoute(
      builder: (context) => AddInputToFarmerScreen(
        userId: userId,
        input: input,
      ),
    );
  }

  final String userId;
  final Input input;
  const AddInputToFarmerScreen({
    super.key,
    required this.userId,
    required this.input,
  });

  @override
  State<AddInputToFarmerScreen> createState() => _AddInputToFarmerScreenState();
}

class _AddInputToFarmerScreenState extends State<AddInputToFarmerScreen> {
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
      body: BlocListener<FarmerInputBloc, FarmerInputState>(
        listener: (context, state) {
          if (state is LoadedFarmerInputs) {
            context.read<FarmerBloc>().add(LoadFarmer(id: widget.userId));
            Navigator.pop(context);
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: BlocBuilder<FarmerBloc, FarmerState>(
            builder: (context, state) {
              if (state is LoadedFarmer) {
                final farmer = state.farmer;

                return Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      InputItem(
                        name: widget.input.name,
                        quantity: widget.input.quantity,
                        unit: widget.input.unit,
                        date: widget.input.createdAt,
                      ),
                      CustomSpaces.verticalSpace(height: 15),
                      CustomTextField(
                        label: "Quantity",
                        keyboardType: TextInputType.number,
                        controller: _quantityController,
                      ),
                      BlocBuilder<FarmerInputBloc, FarmerInputState>(
                        builder: (context, state) {
                          if (state is FarmerInputStateError) {
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
                      BlocBuilder<FarmerInputBloc, FarmerInputState>(
                        builder: (context, state) {
                          if (state is FarmerInputStateLoading) {
                            return const CustomButton();
                          }
                          return CustomButton(
                            label: "Submit",
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<FarmerInputBloc>().add(
                                      AddFarmerInputEvent(
                                        quantity: int.parse(
                                            _quantityController.text.trim()),
                                        inputId: widget.input.id,
                                        userId: farmer.id,
                                      ),
                                    );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                );
              }

              if (state is FarmerStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return CustomButton(
                label: "Reload",
                onPressed: () {
                  context.read<FarmerBloc>().add(LoadFarmer(id: widget.userId));
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
