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
          modifierInt: $checkedConvert('Modifier', (v) => v as String?),
          masterCode: $checkedConvert('MasterCode', (v) => v as String?),
          hidden: $checkedConvert('Hidden', (v) => v as String?),
          promoCode: $checkedConvert('PromoCode', (v) => v as String?),
          promoClass: $checkedConvert('PromoClass', (v) => v as String?),
          pkgPrice: $checkedConvert('PkgPrice', (v) => v as String?),
          pkgQty: $checkedConvert('PkgQty', (v) => v as String?),
          pkgItems: $checkedConvert('PkgItems', (v) => v as String?),
          blanket: $checkedConvert('Blanket', (v) => v as String?),
          tax: $checkedConvert('Tax', (v) => v as String?),
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
        'discountable': 'Discountable',
        'modifierInt': 'Modifier',
        'masterCode': 'MasterCode',
        'hidden': 'Hidden',
        'promoCode': 'PromoCode',
        'promoClass': 'PromoClass',
        'pkgPrice': 'PkgPrice',
        'pkgQty': 'PkgQty',
        'pkgItems': 'PkgItems',
        'blanket': 'Blanket',
        'tax': 'Tax'
      },
    );
