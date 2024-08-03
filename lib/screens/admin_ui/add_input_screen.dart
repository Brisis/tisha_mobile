import 'package:flutter/material.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/custom_text_field.dart';
import 'package:tisha_app/screens/widgets/searchable_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AddInputScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const AddInputScreen(),
    );
  }

  const AddInputScreen({super.key});

  @override
  State<AddInputScreen> createState() => _AddInputScreenState();
}

class _AddInputScreenState extends State<AddInputScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final TextEditingController _quantityUnitController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "New Input",
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
                label: "Input Name",
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
                label: "Quantity",
                keyboardType: TextInputType.number,
                controller: _quantityController,
              ),
              CustomSpaces.verticalSpace(height: 15),
              CustomTextField(
                label: "Quantity Unit",
                controller: _quantityUnitController,
              ),
              CustomSpaces.verticalSpace(height: 15),
              CustomDropDown(
                items: [],
                labelText: "Choose targeted Location",
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
