import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class AddInputToFarmerScreen extends StatefulWidget {
  static Route route({required String userId}) {
    return MaterialPageRoute(
      builder: (context) => AddInputToFarmerScreen(
        userId: userId,
      ),
    );
  }

  final String userId;
  const AddInputToFarmerScreen({
    super.key,
    required this.userId,
  });

  @override
  State<AddInputToFarmerScreen> createState() => _AddInputToFarmerScreenState();
}

class _AddInputToFarmerScreenState extends State<AddInputToFarmerScreen> {
  List<String> selectedInputs = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColors.kBackgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Assign Inputs",
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
                  ? Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListView.builder(
                          itemCount: inputs.length,
                          itemBuilder: (_, int index) {
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: Card(
                                color: CustomColors.kContainerBackgroundColor,
                                elevation: 2.0,
                                child: CheckboxListTile(
                                  title: Text(inputs[index].name),
                                  subtitle: Text(
                                    "${inputs[index].quantity} ${inputs[index].unit}",
                                  ),
                                  value:
                                      selectedInputs.contains(inputs[index].id),
                                  onChanged: (_) {
                                    if (selectedInputs
                                        .contains(inputs[index].id)) {
                                      setState(() {
                                        selectedInputs.remove(inputs[index].id);
                                      }); // unselect
                                    } else {
                                      setState(() {
                                        selectedInputs
                                            .add(inputs[index].id); // select
                                      });
                                    }
                                  },
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                ),
                              ),
                            );
                          },
                        ),
                        CustomSpaces.verticalSpace(height: 30),
                        BlocBuilder<InputBloc, InputState>(
                          builder: (context, state) {
                            if (state is InputStateLoading) {
                              return const CustomButton();
                            }
                            return CustomButton(
                              label: "Submit",
                              onPressed: () {
                                if (selectedInputs.isNotEmpty) {
                                  context.read<FarmerInputBloc>().add(
                                        AddFarmerInputEvent(
                                          inputs: selectedInputs,
                                          userId: widget.userId,
                                        ),
                                      );
                                }
                              },
                            );
                          },
                        ),
                      ],
                    )
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
