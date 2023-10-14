part of 'objects_screen_bloc.dart';

abstract class ObjectsScreenState extends Equatable {
  const ObjectsScreenState();
}

class ObjectsScreenInitial extends ObjectsScreenState {
  @override
  List<Object> get props => [];
}

class Loading extends ObjectsScreenState {
  @override
  List<Object?> get props => [];
}

class Loaded extends ObjectsScreenState {
  final List<Object3Ddto> objects;

  const Loaded({required this.objects});

  @override
  List<Object?> get props => [objects];
}

class ErrorObject extends ObjectsScreenState {
  final String message;

  const ErrorObject({required this.message});

  @override
  List<Object?> get props => [message];
}
