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
  @JsonKey(name: 'type')
  final String type;
  @JsonKey(name: 'vat')
  final String vat;
  @JsonKey(name: 'isCashier')
  final String isCashier;

  @override
  List<Object> get props =>
      [serverIP, posGroup, posId, type, storeNo, vat, isCashier];

  const Setting(
      {required this.serverIP,
      required this.posGroup,
      required this.posId,
      required this.type,
      required this.storeNo,
      required this.vat,
      required this.isCashier
  });

  static const empty = Setting(serverIP: '',
      posGroup: '',
      posId: '',
      type: '',
      storeNo: '', vat: '', isCashier: '0');

  factory Setting.fromJson(Map<String, dynamic> json) =>
      _$SettingFromJson(json);

  Map<String, dynamic> toJson() => {
        'serverIP': serverIP,
        'posGroup': posGroup,
        'posId': posId,
        'type': type,
        'storeNo': storeNo,
        'vat': vat,
        'isCashier': isCashier
      };
}
