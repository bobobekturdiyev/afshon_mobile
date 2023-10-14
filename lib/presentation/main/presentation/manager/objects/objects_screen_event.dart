part of 'objects_screen_bloc.dart';

abstract class ObjectsScreenEvent extends Equatable {
  const ObjectsScreenEvent();
}

class LoadSubjectObjects extends ObjectsScreenEvent {
  final int subjectId;

  const LoadSubjectObjects({required this.subjectId});
  @override
  List<Object?> get props => [subjectId];
}
