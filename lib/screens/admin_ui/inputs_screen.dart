import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/screens/admin_ui/add_input_screen.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/input_item.dart';
import 'package:tisha_app/theme/colors.dart';

class InputsScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const InputsScreen(),
    );
  }

  const InputsScreen({super.key});

  @override
  State<InputsScreen> createState() => _InputsScreenState();
}

class _InputsScreenState extends State<InputsScreen> {
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
          "Registered Inputs",
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
                            onTap: () {},
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: CustomColors.kPrimaryColor,
        onPressed: () {
          Navigator.push(context, AddInputScreen.route());
        },
        shape: const CircleBorder(),
        child: Icon(
          Icons.add,
          color: CustomColors.kWhiteTextColor,
        ),
      ),
    );
  }
}
