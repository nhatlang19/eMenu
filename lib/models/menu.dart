import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'menu.g.dart';

@JsonSerializable()
class Menu extends Equatable {
  @JsonKey(name: 'BtnColor')
  final String btnColor;
  @JsonKey(name: 'Description')
  final String description;
  @JsonKey(name: 'FontColor')
  final String fontColor;
  @JsonKey(name: 'DefaultValue')
  final String defaultValue;
  @JsonKey(name: 'Bitmap')
  final String? bitmap;

  @override
  List<Object> get props => [description, btnColor, fontColor, defaultValue, bitmap ?? ''];

  static const empty =
      Menu(description: '', btnColor: '', fontColor: '', defaultValue: '', bitmap: '');

  const Menu({
    required this.description,
    required this.btnColor,
    required this.fontColor,
    required this.defaultValue,
    required this.bitmap,
  });

  factory Menu.fromJson(Map<String, dynamic> json) => _$MenuFromJson(json);
}
