import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'submenu.g.dart';

@JsonSerializable()
class Submenu extends Equatable {
  @JsonKey(name: 'BtnColor')
  final String btnColor;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'FontColor')
  final String fontColor;
  @JsonKey(name: 'DefaultValue')
  final String defaultValue;
  @JsonKey(name: 'SeqNum')
  final String seqNum;

  @override
  List<Object> get props => [description, btnColor, fontColor, defaultValue, seqNum];

  static const empty =
      Submenu(description: '', btnColor: '', fontColor: '', defaultValue: '', seqNum: '');

  const Submenu({
    required this.description,
    required this.btnColor,
    required this.fontColor,
    required this.defaultValue,
    required this.seqNum
  });

  factory Submenu.fromJson(Map<String, dynamic> json) => _$SubmenuFromJson(json);
}
