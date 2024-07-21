// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'item_modifier.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemModifier _$ItemModifierFromJson(Map<String, dynamic> json) =>
    $checkedCreate(
      'ItemModifier',
      json,
      ($checkedConvert) {
        final val = ItemModifier(
          itemCode: $checkedConvert('ItemCode', (v) => v as String?),
          modCode: $checkedConvert('ModCode', (v) => v as String?),
          quantity: $checkedConvert('Quantity', (v) => v as String?),
          modDesc: $checkedConvert('ModDesc', (v) => v as String?),
          unitPrice: $checkedConvert('UnitPrice', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'itemCode': 'ItemCode',
        'modCode': 'ModCode',
        'quantity': 'Quantity',
        'modDesc': 'ModDesc',
        'unitPrice': 'UnitPrice'
      },
    );
