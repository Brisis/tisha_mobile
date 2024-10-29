import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/input.dart';
import 'package:tisha_app/logic/input_bloc/input_bloc.dart';
import 'package:tisha_app/screens/admin_ui/add_input_screen.dart';
import 'package:tisha_app/screens/admin_ui/admin_home_screen.dart';
import 'package:tisha_app/screens/widgets/custom_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

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
      },
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
          backgroundColor: CustomColors.kPrimaryColor,
          leading: IconButton(
            onPressed: () => Navigator.push(context, AdminHomeScreen.route()),
            icon: const Icon(Icons.arrow_back),
          ),
          elevation: 1.0,
          title: Text(
            "Input Tracker",
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
                                .contains(value.toLowerCase()) ||
                            inp.chassisNumber
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
                                'Bar Code',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Chassis Number',
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
                                  Text(input.barcode),
                                ),
                                DataCell(
                                  Text(input.chassisNumber ?? ""),
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
      ),
    );
  }
}
