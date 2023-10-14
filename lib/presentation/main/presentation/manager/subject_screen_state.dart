part of 'subject_screen_bloc.dart';

abstract class SubjectScreenState extends Equatable {
  const SubjectScreenState();
}

class SubjectScreenInitial extends SubjectScreenState {
  @override
  List<Object> get props => [];
}

class Loading extends SubjectScreenState {
  @override
  List<Object?> get props => [];
}

class Loaded extends SubjectScreenState {
  final List<SubjectDto> subjects;

  const Loaded({required this.subjects});

  @override
  List<Object?> get props => [subjects];
}

class ErrorSubject extends SubjectScreenState {
  final String message;

  const ErrorSubject({required this.message});

  @override
  List<Object?> get props => [message];
}
