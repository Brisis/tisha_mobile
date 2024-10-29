part of 'person_bloc.dart';

abstract class PersonState extends Equatable {
  const PersonState();

  @override
  List<Object> get props => [];
}

final class PersonStateInitial extends PersonState {}

class PersonStateLoading extends PersonState {}

class PersonCreated extends PersonState {}

class PersonStateSearchLoading extends PersonState {}

class LoadedPerson extends PersonState {
  final User person;
  const LoadedPerson({
    required this.person,
  });

  @override
  List<Object> get props => [person];

  @override
  bool? get stringify => true;
}

class LoadedPeople extends PersonState {
  final List<User> people;
  const LoadedPeople({
    required this.people,
  });

  @override
  List<Object> get props => [people];

  @override
  bool? get stringify => true;
}

class LoadedSearchPeople extends PersonState {
  final List<User> people;
  const LoadedSearchPeople({
    required this.people,
  });

  @override
  List<Object> get props => [people];

  @override
  bool? get stringify => true;
}

class PersonStateError extends PersonState {
  final AppException? message;
  const PersonStateError({
    this.message,
  });

  @override
  List<Object> get props => [message!];
}

extension GetPeople on PersonState {
  List<User> get people {
    final cls = this;
    if (cls is LoadedPeople) {
      return cls.people;
    } else {
      return [];
    }
  }
}

extension GetPerson on PersonState {
  User? get person {
    final cls = this;
    if (cls is LoadedPerson) {
      return cls.person;
    } else {
      return null;
    }
  }
}
