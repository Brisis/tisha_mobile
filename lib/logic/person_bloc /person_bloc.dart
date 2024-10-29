import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tisha_app/core/config/exception_handlers.dart';
import 'package:tisha_app/core/config/storage.dart';
import 'package:tisha_app/data/models/user.dart';
import 'package:tisha_app/data/repositories/person/person_repository.dart';

part 'person_event.dart';
part 'person_state.dart';

class PersonBloc extends Bloc<PersonEvent, PersonState> {
  final PersonRepository personRepository;
  PersonBloc({
    required this.personRepository,
  }) : super(PersonStateInitial()) {
    on<LoadPeople>((event, emit) async {
      emit(PersonStateLoading());
      try {
        final token = await getAuthToken();

        final people = await personRepository.getPeople(
          token: token!,
        );

        emit(LoadedPeople(people: people));
      } on AppException catch (e) {
        emit(
          PersonStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          PersonStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<AddPersonEvent>((event, emit) async {
      emit(PersonStateLoading());
      try {
        final token = await getAuthToken();

        final people = await personRepository.addPerson(
          token: token!,
          firstname: event.firstname,
          lastname: event.lastname,
          dob: event.dob,
          age: event.dob != null
              ? (DateTime.now().year - event.dob!.year)
              : null,
          gender: event.gender,
          phone: event.phone,
          address: event.address,
          nationalId: event.nationalId,
          //farm detai.ls
          landOwnership: event.landOwnership,
          farmerType: event.farmerType,
          cropType: event.cropType,
          livestockType: event.livestockType,
          livestockNumber: event.livestockNumber,
          farmSize: event.farmSize,
          locationId: event.locationId,
          coordinates: event.coordinates,
          role: event.role,
          email: event.email,
          password: event.password,
        );

        emit(PersonCreated());
        emit(LoadedPeople(people: people));
      } on AppException catch (e) {
        emit(
          PersonStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          PersonStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<SearchPerson>((event, emit) async {
      emit(PersonStateSearchLoading());
      try {
        final token = await getAuthToken();

        List<User> people = [];

        if (event.query != null && event.locationId != null) {
          people = await personRepository.getPeople(
            token: token!,
            query: event.query,
          );
          people = people
              .where((person) => person.locationId == event.locationId)
              .toList();
        } else if (event.locationId != null) {
          people = await personRepository.getPeople(
            token: token!,
          );
          people = people
              .where((person) => person.locationId == event.locationId)
              .toList();
        } else {
          people = await personRepository.getPeople(
            token: token!,
            query: event.query,
          );
        }

        emit(LoadedSearchPeople(people: people));
      } on AppException catch (e) {
        emit(
          PersonStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          PersonStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });

    on<LoadPerson>((event, emit) async {
      emit(PersonStateLoading());
      try {
        final token = await getAuthToken();

        final person = await personRepository.getPerson(
          token: token!,
          id: event.id,
        );

        emit(LoadedPerson(person: person));
      } on AppException catch (e) {
        emit(
          PersonStateError(
            message: e,
          ),
        );
      } on TimeoutException catch (e) {
        emit(
          PersonStateError(
            message: AppException(
              message: e.message,
            ),
          ),
        );
      }
    });
  }
}
