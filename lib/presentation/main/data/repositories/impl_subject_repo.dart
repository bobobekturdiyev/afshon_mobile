import 'package:afshon_ar/core/error/exception_handler.dart';
import 'package:afshon_ar/core/resources/data_state.dart';
import 'package:afshon_ar/presentation/main/data/data_sources/subject_service.dart';
import 'package:afshon_ar/presentation/main/data/models/object_3d_dto.dart';
import 'package:afshon_ar/presentation/main/data/models/subject_dto.dart';
import 'package:afshon_ar/presentation/main/domain/entities/search_request.dart';
import 'package:afshon_ar/presentation/main/domain/repositories/subject_repo.dart';

class ImplSubjectRepo extends SubjectRepo {
  SubjectService subjectService;

  ImplSubjectRepo({
    required this.subjectService,
  });

  @override
  Future<DataState<List<SubjectDto>>> getSubjects() async {
    try {
      final result = await subjectService.getSubjects();
      return DataSuccess(data: result.data);
    } catch (e) {
      return DataException.getError(e);
    }
  }

  @override
  Future<DataState<List<Object3Ddto>>> getSubjectObjects(
      {required int subjectId}) async {
    try {
      final result =
          await subjectService.getSubjectObjects(subjectId: subjectId);
      return DataSuccess(data: result.data);
    } catch (e) {
      return DataException.getError(e);
    }
  }

  @override
  Future<DataState<List<Object3Ddto>>> search({required String text}) async {
    try {
      final result =
          await subjectService.search(searchRequest: SearchRequest(text: text));
      return DataSuccess(data: result.data);
    } catch (e) {
      return DataException.getError(e);
    }
  }
}
