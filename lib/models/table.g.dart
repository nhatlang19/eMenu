// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'table.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Table _$TableFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Table',
      json,
      ($checkedConvert) {
        final val = Table(
          TableNo: $checkedConvert('TableNo', (v) => v as String),
          Status: $checkedConvert('Status', (v) => v as String?),
          OpenBy: $checkedConvert('OpenBy', (v) => v as String?),
          Desciption: $checkedConvert('Desciption', (v) => v as String?),
          SalesCode: $checkedConvert('SalesCode', (v) => v as String?),
        );
        return val;
      },
    );
