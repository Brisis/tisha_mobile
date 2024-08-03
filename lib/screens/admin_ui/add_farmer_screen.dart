import 'package:flutter/material.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/searchable_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AddFarmerScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AddFarmerScreen(),
    );
  }

  const AddFarmerScreen({super.key});

  @override
  State<AddFarmerScreen> createState() => _AddFarmerScreenState();
}

class _AddFarmerScreenState extends State<AddFarmerScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _sizeController = TextEditingController();
  final TextEditingController _coordinatesController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "New Farmer",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                "Complete Form",
                style: Theme.of(context).textTheme.displaySmall,
              ),
              CustomSpaces.verticalSpace(height: 15),
              CustomTextField(
                label: "Full name",
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
                label: "Farm size (h.a)",
                keyboardType: TextInputType.number,
                controller: _sizeController,
              ),
              CustomSpaces.verticalSpace(height: 15),
              CustomDropDown(
                items: [],
                labelText: "Choose Location",
              ),
              CustomSpaces.verticalSpace(height: 15),
              CustomTextField(
                label: "Coordinates",
                controller: _coordinatesController,
              ),
              CustomSpaces.verticalSpace(height: 15),
              CustomTextField(
                label: "Email Address",
                controller: _emailController,
              ),
              CustomSpaces.verticalSpace(height: 15),
              CustomTextField(
                label: "Password",
                controller: _passwordController,
              ),
              CustomSpaces.verticalSpace(height: 30),
              CustomButton(
                label: "Submit",
                onPressed: () {
                  if (_formKey.currentState!.validate()) {}
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
