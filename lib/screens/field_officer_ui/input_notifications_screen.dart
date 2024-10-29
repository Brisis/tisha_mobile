import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/screens/field_officer_ui/field_officer_home_screen.dart';
import 'package:tisha_app/screens/widgets/custom_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class InputNotificationsScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const InputNotificationsScreen(),
    );
  }

  const InputNotificationsScreen({super.key});

  @override
  State<InputNotificationsScreen> createState() =>
      _InputNotificationsScreenState();
}

class _InputNotificationsScreenState extends State<InputNotificationsScreen> {
  late String selectedDateFilter;
  String? selectedStatusFilter;
  List<Input> inputs = [];
  List<Input> dispInputs = [];
  @override
  void initState() {
    super.initState();
    context.read<InputBloc>().add(LoadInputs());
    selectedDateFilter = "Desc";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<InputBloc, InputState>(
      listener: (context, state) {
        if (state is LoadedInputs) {
          setState(() {
            inputs = state.inputs;
            dispInputs = inputs;
          });
        }

        if (state is NotificationSent) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Notification created"),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
          backgroundColor: CustomColors.kPrimaryColor,
          leading: IconButton(
            onPressed: () =>
                Navigator.push(context, FieldOfficerHomeScreen.route()),
            icon: const Icon(Icons.arrow_back),
          ),
          elevation: 1.0,
          title: Text(
            "Notify Farmers",
            style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                  color: CustomColors.kWhiteTextColor,
                ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CupertinoSearchTextField(
                onSubmitted: (value) {
                  setState(() {
                    dispInputs = inputs
                        .where((inp) =>
                            inp.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            inp.barcode
                                .toString()
                                .toLowerCase()
                                .contains(value.toLowerCase()))
                        .toList();
                  });
                },
              ),
              CustomSpaces.verticalSpace(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: CustomDropdown(
                      selectedItem: selectedDateFilter,
                      onChanged: (value) {
                        if (value == "Asc") {
                          setState(() {
                            selectedDateFilter = value!;
                            dispInputs = inputs.reversed.toList();
                          });
                        } else {
                          setState(() {
                            selectedDateFilter = value!;
                            dispInputs = inputs;
                          });
                        }
                      },
                      hintText: "Filter by Date",
                      items: const ["Asc", "Desc"],
                    ),
                  ),
                  CustomSpaces.horizontalSpace(width: 15),
                  Expanded(
                    child: CustomDropdown(
                      selectedItem: selectedStatusFilter,
                      onChanged: (value) {
                        setState(() {
                          selectedStatusFilter = value;
                          dispInputs = inputs
                              .where((input) => input.type.name == value)
                              .toList();
                        });
                      },
                      hintText: "Filter Type",
                      items: const [
                        "Tructor",
                        "Seeds",
                        "Fertiliser",
                        "Insecticide"
                      ],
                    ),
                  ),
                ],
              ),
              dispInputs.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showBottomBorder: true,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Name',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Notified',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Bar Code',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Quantity',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Unit',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Type',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Scheme',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          for (var input in dispInputs)
                            DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Text(
                                    input.name,
                                  ),
                                ),
                                DataCell(
                                  input.notified
                                      ? Text(
                                          "Yes",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium!
                                              .copyWith(
                                                fontWeight: FontWeight.w500,
                                                color:
                                                    CustomColors.kPrimaryColor,
                                              ),
                                        )
                                      : ElevatedButton(
                                          onPressed: () => _showYesNoDialog(
                                            context,
                                            input,
                                          ),
                                          child: Text(
                                            "Notify",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium!
                                                .copyWith(
                                                  fontWeight: FontWeight.w500,
                                                ),
                                          ),
                                        ),
                                ),
                                DataCell(
                                  Text(input.barcode),
                                ),
                                DataCell(
                                  Text(input.quantity.toString()),
                                ),
                                DataCell(
                                  Text(input.unit ?? ""),
                                ),
                                DataCell(
                                  Text(
                                    input.type.name,
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    input.scheme.name,
                                  ),
                                ),
                              ],
                            )
                        ],
                      ),
                    )
                  : Center(
                      child: Text(
                        "0 Found",
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }

  void _showYesNoDialog(BuildContext context, Input input) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content:
              Text("Do you want to make a notification for ${input.name}?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text(
                "Cancel",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                context.read<InputBloc>().add(
                      NotifyInput(
                        inputId: input.id,
                      ),
                    );
                Navigator.pop(context);
              },
              child: const Text(
                "Submit",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
