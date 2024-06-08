// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Item _$ItemFromJson(Map<String, dynamic> json) => $checkedCreate(
      'Item',
      json,
      ($checkedConvert) {
        final val = Item(
          itemCode: $checkedConvert('ItemCode', (v) => v as String),
          recptDesc: $checkedConvert('RecptDesc', (v) => v as String),
          unitSellPrice: $checkedConvert('UnitSellPrice', (v) => v as String),
          comboPack: $checkedConvert('ComboPack', (v) => v as String),
          weightItem: $checkedConvert('WeightItem', (v) => v as String),
          onPromotion: $checkedConvert('OnPromotion', (v) => v as String),
          promoPrice: $checkedConvert('PromoPrice', (v) => v as String),
          discountable: $checkedConvert('Discountable', (v) => v as String),
        );
        return val;
      },
      fieldKeyMap: const {
        'itemCode': 'ItemCode',
        'recptDesc': 'RecptDesc',
        'unitSellPrice': 'UnitSellPrice',
        'comboPack': 'ComboPack',
        'weightItem': 'WeightItem',
        'onPromotion': 'OnPromotion',
        'promoPrice': 'PromoPrice',
        'discountable': 'Discountable'
      },
    );
