import 'package:afshon_ar/core/resources/data_state.dart';
import 'package:afshon_ar/presentation/main/data/models/object_3d_dto.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../domain/repositories/subject_repo.dart';

part 'objects_screen_event.dart';
part 'objects_screen_state.dart';

class ObjectsScreenBloc extends Bloc<ObjectsScreenEvent, ObjectsScreenState> {
  final SubjectRepo subjectRepo;
  final int subjectId;

  List<Object3Ddto> objects = [];

  ObjectsScreenBloc({
    required this.subjectRepo,
    required this.subjectId,
  }) : super(ObjectsScreenInitial()) {
    on<LoadSubjectObjects>((event, emit) async {
      emit(Loading());

      final result =
          await subjectRepo.getSubjectObjects(subjectId: event.subjectId);

      if (result is DataSuccess) {
        objects = result.data ?? [];
        emit(Loaded(objects: objects));
      } else {
        final errorMessage = result.errorResponse?.message;
        emit(ErrorObject(message: errorMessage ?? ""));
      }
    });
    add(LoadSubjectObjects(subjectId: subjectId));
  }
}
