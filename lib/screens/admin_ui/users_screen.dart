import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/logic/person_bloc%20/person_bloc.dart';
import 'package:tisha_app/screens/admin_ui/add_user_screen.dart';
import 'package:tisha_app/screens/admin_ui/admin_home_screen.dart';
import 'package:tisha_app/screens/widgets/custom_dropdown.dart';
import 'package:tisha_app/theme/colors.dart';
import 'package:tisha_app/theme/spaces.dart';

class UsersScreen extends StatefulWidget {
  static Route route() {
    return MaterialPageRoute(
      builder: (context) => const UsersScreen(),
    );
  }

  const UsersScreen({super.key});

  @override
  State<UsersScreen> createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  late String selectedDateFilter;
  String? selectedStatusFilter;
  List<User> people = [];
  List<User> dispPeople = [];
  @override
  void initState() {
    super.initState();
    context.read<PersonBloc>().add(LoadPeople());
    selectedDateFilter = "Desc";
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PersonBloc, PersonState>(
      listener: (context, state) {
        if (state is LoadedPeople) {
          setState(() {
            people = state.people;
            dispPeople = people;
          });
        }
      },
      child: Scaffold(
        backgroundColor: CustomColors.kBackgroundColor,
        appBar: AppBar(
          iconTheme: IconThemeData(color: CustomColors.kWhiteTextColor),
          backgroundColor: CustomColors.kPrimaryColor,
          elevation: 1.0,
          leading: IconButton(
            onPressed: () => Navigator.push(context, AdminHomeScreen.route()),
            icon: const Icon(Icons.arrow_back),
          ),
          title: Text(
            "All Users",
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
                    dispPeople = people
                        .where((inp) =>
                            inp.firstname
                                .toLowerCase()
                                .contains(value.toLowerCase()) ||
                            inp.lastname
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
                            dispPeople = people.reversed.toList();
                          });
                        } else {
                          setState(() {
                            selectedDateFilter = value!;
                            dispPeople = people;
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
                          dispPeople = people
                              .where((person) => person.role.name == value)
                              .toList();
                        });
                      },
                      hintText: "Filter Role",
                      items: const [
                        "FARMER",
                        "INPUTCOORDINATOR",
                        "FIELDOFFICER",
                        "SUPERUSER"
                      ],
                    ),
                  ),
                ],
              ),
              dispPeople.isNotEmpty
                  ? SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        showBottomBorder: true,
                        columns: const <DataColumn>[
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Firstname',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Lastname',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Gender',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'D.O.B',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                          DataColumn(
                            label: Expanded(
                              child: Text(
                                'Role',
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                          ),
                        ],
                        rows: [
                          for (var person in dispPeople)
                            DataRow(
                              cells: <DataCell>[
                                DataCell(
                                  Text(
                                    person.firstname,
                                  ),
                                ),
                                DataCell(
                                  Text(person.lastname ?? ""),
                                ),
                                DataCell(
                                  Text(person.gender?.name ?? ""),
                                ),
                                DataCell(
                                  Text(person.dob
                                          ?.toIso8601String()
                                          .substring(0, 10) ??
                                      ""),
                                ),
                                DataCell(
                                  Text(
                                    person.role.name,
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
            Navigator.push(context, AddUserScreen.route());
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
