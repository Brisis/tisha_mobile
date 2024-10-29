import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_button.dart';
import 'package:tisha_app/screens/widgets/input_item.dart';
import 'package:tisha_app/theme/colors.dart';

class FarmerInputsScreen extends StatelessWidget {
  static Route route({required String userId}) {
    return MaterialPageRoute(
      builder: (context) => FarmerInputsScreen(
        userId: userId,
      ),
    );
  }

  final String userId;

  const FarmerInputsScreen({
    super.key,
    required this.userId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
        backgroundColor: CustomColors.kPrimaryColor,
        elevation: 1.0,
        title: Text(
          "Assigned Inputs",
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                color: CustomColors.kWhiteTextColor,
              ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: BlocBuilder<FarmerInputBloc, FarmerInputState>(
          builder: (context, state) {
            if (state is LoadedFarmerInputs) {
              final inputs = state.inputs.reversed.toList();
              return inputs.isNotEmpty
                  ? ListView.builder(
                      itemCount: inputs.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InputItem(
                            name: inputs[index].input.name,
                            quantity: inputs[index].quantity,
                            unit: inputs[index].input.unit ?? "",
                            received: inputs[index].received,
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

            if (state is FarmerInputStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return CustomButton(
              label: "Reload",
              onPressed: () {
                context.read<FarmerInputBloc>().add(
                      LoadFarmerInputs(userId: userId),
                    );
              },
            );
          },
        ),
      ),
    );
  }
}
