import 'package:afshon_ar/core/resources/data_state.dart';
import 'package:afshon_ar/presentation/main/data/models/object_3d_dto.dart';
import 'package:afshon_ar/presentation/main/domain/repositories/subject_repo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SubjectRepo subjectRepo;

  SearchBloc({
    required this.subjectRepo,
  }) : super(SearchInitial()) {
    on<SearchText>((event, emit) async {
      emit(LoadingSearch());

      final result = await subjectRepo.search(text: event.text);

      if (result is DataSuccess) {
        emit(LoadedSearch(objects: result.data ?? []));
      } else {
        final errorMessage = result.errorResponse?.message;
        emit(ErrorSearch(message: errorMessage ?? ""));
      }
    });
  }
}
