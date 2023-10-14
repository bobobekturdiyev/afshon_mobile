part of 'subject_screen_bloc.dart';

abstract class SubjectScreenEvent extends Equatable {
  const SubjectScreenEvent();
}

class LoadSubject extends SubjectScreenEvent {
  @override
  List<Object?> get props => [];
}
