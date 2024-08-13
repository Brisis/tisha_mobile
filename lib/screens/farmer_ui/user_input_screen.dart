import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/farmer_input.dart';
import 'package:tisha_app/logic/auth_bloc/authentication_bloc.dart';
import 'package:tisha_app/logic/farmer_bloc/farmer_bloc.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/logic/user_bloc/user_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/input_item.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class UserInputScreen extends StatefulWidget {
  static Route route({
    required String userId,
    required FarmerInput input,
  }) {
    return MaterialPageRoute(
      builder: (context) => UserInputScreen(
        userId: userId,
        input: input,
      ),
    );
  }

  final String userId;
  final FarmerInput input;
  const UserInputScreen({
    super.key,
    required this.userId,
    required this.input,
  });

  @override
  State<UserInputScreen> createState() => _UserInputScreenState();
}

class _UserInputScreenState extends State<UserInputScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _paybackController = TextEditingController();
  late bool checkedValue;

  @override
  void initState() {
    super.initState();
    checkedValue = widget.input.received;
    _paybackController.text =
        widget.input.payback != null ? widget.input.payback.toString() : "";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Update Input",
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
          child: BlocBuilder<UserBloc, UserState>(
            builder: (context, state) {
              if (state is LoadedUser) {
                return Form(
                  key: _formKey,
                  child: ListView(
                    children: [
                      InputItem(
                        name: widget.input.input.name,
                        quantity: widget.input.quantity,
                        unit: widget.input.input.unit,
                        date: widget.input.createdAt,
                      ),
                      CustomSpaces.verticalSpace(height: 15),
                      CheckboxListTile(
                        title: const Text("I confirm to receive the input"),
                        value: checkedValue,
                        onChanged: (newValue) {
                          setState(() {
                            checkedValue = newValue!;
                          });
                        },
                        controlAffinity: ListTileControlAffinity.leading,
                      ),
                      CustomTextField(
                        label: "Payback",
                        keyboardType: TextInputType.number,
                        controller: _paybackController,
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
                                      UpdateFarmerInputEvent(
                                        payback: double.parse(
                                            _paybackController.text.trim()),
                                        inputId: widget.input.id,
                                        received: checkedValue,
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
                );
              }

              if (state is UserStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              return CustomButton(
                label: "Reload",
                onPressed: () {
                  context
                      .read<AuthenticationBloc>()
                      .add(AuthenticationEventInitialize());
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
