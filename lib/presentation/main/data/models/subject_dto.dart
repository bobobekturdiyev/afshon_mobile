import 'package:json_annotation/json_annotation.dart';

part 'subject_dto.g.dart';

@JsonSerializable()
class SubjectDto {
  final int id;
  final String title;
  final String image;
  final int views;
  final int total;

  const SubjectDto({
    required this.id,
    required this.title,
    required this.image,
    this.total = 5,
    this.views = 0,
  });

  factory SubjectDto.fromJson(Map<String, dynamic> json) =>
      _$SubjectDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SubjectDtoToJson(this);
}
