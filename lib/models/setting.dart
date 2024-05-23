import 'package:json_annotation/json_annotation.dart';

part 'setting.g.dart';

@JsonSerializable()
class Setting {
  @JsonKey(name: 'serverIP')
  final String serverIP;
  @JsonKey(name: 'storeNo')
  final String storeNo;
  @JsonKey(name: 'posGroup')
  final String posGroup;
  @JsonKey(name: 'posId')
  final String posId;
  @JsonKey(name: 'vat')
  final String vat;
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'serviceTax')
  final String serviceTax;
  @JsonKey(name: 'section')
  final String section;

  @override
  List<Object> get props =>
      [serverIP, storeNo, posGroup, posId, vat, type, serviceTax, section];

  const Setting(
      {required this.serverIP,
      required this.storeNo,
      required this.posGroup,
      required this.posId,
      required this.vat,
      required this.type,
      required this.serviceTax,
      required this.section});

  static const empty = Setting(serverIP: '',
      storeNo: '',
      posGroup: '',
      posId: '',
      vat: '',
      type: '',
      serviceTax: '',
      section: '');

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => {
        'serverIP': serverIP,
        'storeNo': storeNo,
        'posGroup': posGroup,
        'posId': posId,
        'vat': vat,
        'type': type,
        'serviceTax': serviceTax,
        'section': section
      };
}
