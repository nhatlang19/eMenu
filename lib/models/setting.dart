import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting {
  @JsonKey(name: 'serverIP')
  final String serverIP;
  @JsonKey(name: 'posGroup')
  final String posGroup;
  @JsonKey(name: 'posId')
  final String posId;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'section')
  final String section;

  @override
  List<Object> get props =>
      [serverIP, posGroup, posId, type, section];

  const Setting(
      {required this.serverIP,
      required this.posGroup,
      required this.posId,
      required this.type,
      required this.section});

  static const empty = Setting(serverIP: '',
      posGroup: '',
      posId: '',
      type: '',
      section: '');

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => {
        'serverIP': serverIP,
        'posGroup': posGroup,
        'posId': posId,
        'type': type,
        'section': section
      };
}
