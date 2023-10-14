import 'package:afshon_ar/core/resources/data_state.dart';
import 'package:afshon_ar/presentation/main/data/models/object_3d_dto.dart';
import 'package:afshon_ar/presentation/main/data/models/subject_dto.dart';

abstract class SubjectRepo {
  Future<DataState<List<SubjectDto>>> getSubjects();
  Future<DataState<List<Object3Ddto>>> getSubjectObjects({ required int subjectId});
}
