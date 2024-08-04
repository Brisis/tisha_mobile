import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/location_bloc/location_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AddLocationScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AddLocationScreen(),
    );
  }

  const AddLocationScreen({super.key});

  @override
  State<AddLocationScreen> createState() => _AddLocationScreenState();
}

class _AddLocationScreenState extends State<AddLocationScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "New Location",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: BlocListener<LocationBloc, LocationState>(
        listener: (context, state) {
          if (state is LoadedLocations) {
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
                  "Complete Form",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "Location name",
                  controller: _nameController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Name is required';
                    }

                    return null;
                  },
                ),
                CustomSpaces.verticalSpace(height: 15),
                CustomTextField(
                  label: "City",
                  controller: _cityController,
                ),
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationStateError) {
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
                BlocBuilder<LocationBloc, LocationState>(
                  builder: (context, state) {
                    if (state is LocationStateLoading) {
                      return const CustomButton();
                    }
                    return CustomButton(
                      label: "Submit",
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<LocationBloc>().add(
                                AddLocationEvent(
                                  name: _nameController.text.trim(),
                                  city: _cityController.text.trim(),
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
