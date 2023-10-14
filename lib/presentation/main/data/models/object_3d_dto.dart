import 'package:json_annotation/json_annotation.dart';

part 'object_3d_dto.g.dart';

@JsonSerializable()
class Object3Ddto {
  final int id;
  final String name;
  final String excerpt;
  final String image;
  final String url;

  const Object3Ddto({
    required this.id,
    required this.name,
    required this.excerpt,
    required this.image,
    required this.url,
  });

  factory Object3Ddto.fromJson(Map<String, dynamic> json) =>
      _$Object3DdtoFromJson(json);

  Map<String, dynamic> toJson() => _$Object3DdtoToJson(this);
}
