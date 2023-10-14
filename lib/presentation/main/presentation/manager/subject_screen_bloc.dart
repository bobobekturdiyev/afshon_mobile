import 'package:afshon_ar/core/resources/data_state.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/subject_dto.dart';
import '../../domain/repositories/subject_repo.dart';

part 'subject_screen_event.dart';
part 'subject_screen_state.dart';

class SubjectScreenBloc extends Bloc<SubjectScreenEvent, SubjectScreenState> {
  final SubjectRepo subjectRepo;
  List<SubjectDto> subjects = [];

  SubjectScreenBloc({
    required this.subjectRepo,
  }) : super(SubjectScreenInitial()) {
    on<LoadSubject>((event, emit) async {
      emit(Loading());

      final result = await subjectRepo.getSubjects();

      if (result is DataSuccess) {
        subjects = result.data ?? [];
        emit(Loaded(subjects: subjects));
      } else {
        final errorMessage = result.errorResponse?.message;
        emit(ErrorSubject(message: errorMessage ?? ""));
      }
    });
    add(LoadSubject());
  }
}
