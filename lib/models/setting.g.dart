// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'setting.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Setting _$SettingFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Setting',
      json,
      ($checkedConvert) {
        final val = Setting(
          serverIP: $checkedConvert('serverIP', (v) => v as String),
          storeNo: $checkedConvert('storeNo', (v) => v as String),
          posGroup: $checkedConvert('posGroup', (v) => v as String),
          posId: $checkedConvert('posId', (v) => v as String),
          vat: $checkedConvert('vat', (v) => v as String),
          type: $checkedConvert('type', (v) => v as String),
          serviceTax: $checkedConvert('serviceTax', (v) => v as String),
          section: $checkedConvert('section', (v) => v as String),
        );
        return val;
      },
    );
