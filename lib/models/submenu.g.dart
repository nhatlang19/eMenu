// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'submenu.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Submenu _$SubmenuFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Submenu',
      json,
      ($checkedConvert) {
        final val = Submenu(
          description: $checkedConvert('Description', (v) => v as String),
          btnColor: $checkedConvert('BtnColor', (v) => v as String?),
          fontColor: $checkedConvert('FontColor', (v) => v as String?),
          defaultValue: $checkedConvert('DefaultValue', (v) => v as String),
          seqNum: $checkedConvert('SeqNum', (v) => v as String),
          bitmap: $checkedConvert('Bitmap', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'description': 'Description',
        'btnColor': 'BtnColor',
        'fontColor': 'FontColor',
        'defaultValue': 'DefaultValue',
        'seqNum': 'SeqNum',
        'bitmap': 'Bitmap'
      },
    );
