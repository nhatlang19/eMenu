import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'section.g.dart';

@JsonSerializable()
class Section extends Equatable {
  @JsonKey(name: 'Section')
  final String section;
  @JsonKey(name: 'Description1')
  final String description1;

  @override
  List<Object> get props => [section, description1];

  static const empty =
      Section(section: '', description1: '');

  const Section(
      {required this.section,
      required this.description1,
     });

      factory Section.fromJson(Map<String, dynamic> json) => _$SectionFromJson(json);
}
