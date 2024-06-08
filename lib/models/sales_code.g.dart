// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: implicit_dynamic_parameter

part of 'sales_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SalesCode _$SalesCodeFromJson(Map<String, dynamic> json) => $checkedCreate(
      'SalesCode',
      json,
      ($checkedConvert) {
        final val = SalesCode(
          code: $checkedConvert('Code', (v) => v as String),
          description: $checkedConvert('Description', (v) => v as String),
          priceLevel: $checkedConvert('PriceLevel', (v) => v as String?),
          taxClass: $checkedConvert('TaxClass', (v) => v as String?),
          memberType: $checkedConvert('MemberType', (v) => v as String?),
        );
        return val;
      },
      fieldKeyMap: const {
        'code': 'Code',
        'description': 'Description',
        'priceLevel': 'PriceLevel',
        'taxClass': 'TaxClass',
        'memberType': 'MemberType'
      },
    );
