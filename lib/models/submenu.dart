import 'package:emenu/constants/asset_path.dart';
import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'submenu.g.dart';

@JsonSerializable()
class Submenu extends Equatable {

  @JsonKey(name: 'BtnColor')
  final String? btnColor;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'FontColor')
  final String? fontColor;
  @JsonKey(name: 'DefaultValue')
  final String defaultValue;
  @JsonKey(name: 'SeqNum')
  final String seqNum;
  @JsonKey(name: 'Bitmap')
  final String? bitmap;
  @JsonKey(name: 'UnitSellPrice')
  final String? price;
  @JsonKey(name: 'RunOut')
  final String? runOut;

  @override
  List<Object> get props => [description, btnColor ?? '', fontColor ?? '', defaultValue, seqNum, bitmap ?? AssetPath.bitmapDefault, price ?? "0", runOut ?? "0"];

  static const empty =
      Submenu(description: '', btnColor: '', fontColor: '', defaultValue: '', seqNum: '', bitmap: AssetPath.bitmapDefault, price: '0', runOut: '0');

  const Submenu({
    required this.description,
    required this.btnColor,
    required this.fontColor,
    required this.defaultValue,
    required this.seqNum,
    required this.bitmap,
    required this.price,
    required this.runOut,
  });

  factory Submenu.fromJson(Map<String, dynamic> json) => _$SubmenuFromJson(json);

  isRunOut() {
    return this.runOut == "1";
  }
}
