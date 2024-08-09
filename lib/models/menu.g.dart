// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'menu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Menu _$MenuFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Menu',
      json,
      ($checkedConvert) {
        final val = Menu(
          description: $checkedConvert('Description', (v) => v as String),
          btnColor: $checkedConvert('BtnColor', (v) => v as String),
          fontColor: $checkedConvert('FontColor', (v) => v as String),
          defaultValue: $checkedConvert('DefaultValue', (v) => v as String),
          bitmap: $checkedConvert('Bitmap', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'description': 'Description',
        'btnColor': 'BtnColor',
        'fontColor': 'FontColor',
        'defaultValue': 'DefaultValue',
        'bitmap': 'Bitmap'
      },
    );
