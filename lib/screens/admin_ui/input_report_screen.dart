import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/farmer_input.dart';
import 'package:tisha_app/logic/farmer_input_bloc/farmer_input_bloc.dart';
import 'package:tisha_app/screens/widgets/custom_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class InputReportScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const InputReportScreen(),
    );
  }

  const InputReportScreen({super.key});

  @override
  State<InputReportScreen> createState() => _InputReportScreenState();
}

class _InputReportScreenState extends State<InputReportScreen> {
  late String selectedDateFilter;
  String? selectedStatusFilter;
  List<FarmerInput> inputs = [];
  List<FarmerInput> dispInputs = [];
  @override
  void initState() {
    super.initState();
    context.read<FarmerInputBloc>().add(LoadAllFarmerInputs());
    selectedDateFilter = "Desc";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<FarmerInputBloc, FarmerInputState>(
      listener: (context, state) {
        if (state is LoadedFarmerInputs) {
          setState(() {
            inputs = state.inputs;
            dispInputs = inputs;
          });
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.kBackgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
          backgroundColor: CustomColors.kPrimaryColor,
          elevation: 1.0,
          title: Text(
            "Input Reports",
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
                            inp.input.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            inp.user!.name
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            inp.user!.surname
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
                        if (value == "Received") {
                          setState(() {
                            selectedStatusFilter = value;
                            dispInputs = inputs
                                .where((inp) => inp.received == true)
                                .toList();
                          });
                        } else {
                          setState(() {
                            selectedStatusFilter = value;
                            dispInputs = inputs
                                .where((inp) => inp.received == false)
                                .toList();
                          });
                        }
                      },
                      hintText: "Filter by Status",
                      items: const ["Received", "In Progress"],
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
                                'Quantity',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Given',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'To',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Date',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Status',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          for (var farmerInput in dispInputs)
                            DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Text(
                                    farmerInput.input.name,
                                  ),
                                ),
                                DataCell(
                                  Text(farmerInput.input.quantity.toString()),
                                ),
                                DataCell(
                                  Text(farmerInput.quantity.toString()),
                                ),
                                DataCell(
                                  Text(
                                      "${farmerInput.user?.name} ${farmerInput.user?.surname}"),
                                ),
                                DataCell(
                                  Text(
                                    farmerInput.createdAt
                                        .toIso8601String()
                                        .substring(0, 10),
                                  ),
                                ),
                                DataCell(
                                  Text(
                                    farmerInput.received
                                        ? "Received"
                                        : "In Progress",
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
}

class FilterOption extends StatelessWidget {
  final String title;
  final Function()? onTap;
  const FilterOption({
    super.key,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          border: Border.all(
            color: CustomColors.kBorderColor,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
