// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'item_combo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ItemCombo _$ItemComboFromJson(Map<String, dynamic> json) => $checkedCreate(
      'ItemCombo',
      json,
      ($checkedConvert) {
        final val = ItemCombo(
          comboItem: $checkedConvert('ComboItem', (v) => v as String?),
          itemDesc: $checkedConvert('ItemDesc', (v) => v as String?),
          quantity: $checkedConvert('Quantity', (v) => v as String?),
          hidden: $checkedConvert('Hidden', (v) => v as String?),
          modClass: $checkedConvert('ModClass', (v) => v as String?),
          qtyEditable: $checkedConvert('QtyEditable', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'comboItem': 'ComboItem',
        'itemDesc': 'ItemDesc',
        'quantity': 'Quantity',
        'hidden': 'Hidden',
        'modClass': 'ModClass',
        'qtyEditable': 'QtyEditable'
      },
    );
