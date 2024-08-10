// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Order _$OrderFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Order',
      json,
      ($checkedConvert) {
        final val = Order(
          ordExt: $checkedConvert('OrdExt', (v) => v as String),
          posPerScode: $checkedConvert('PosPerScode', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {'ordExt': 'OrdExt', 'posPerScode': 'PosPerScode'},
    );
