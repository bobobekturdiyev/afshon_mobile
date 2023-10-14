import 'package:afshon_ar/core/network/urls.dart';
import 'package:afshon_ar/presentation/main/data/models/object_3d_dto.dart';
import 'package:afshon_ar/presentation/main/data/models/subject_dto.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

part 'subject_service.g.dart';

@RestApi(baseUrl: Urls.baseURl)
abstract class SubjectService {
  factory SubjectService(Dio dio, {String baseUrl}) = _SubjectService;

  @GET("subject")
  Future<HttpResponse<List<SubjectDto>>> getSubjects();

  @GET("file-by-subject/{id}")
  Future<HttpResponse<List<Object3Ddto>>> getSubjectObjects(
      {@Path('id') required int subjectId});
}
