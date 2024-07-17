import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'item.g.dart';

@JsonSerializable()
class Item extends Equatable {
  @JsonKey(name: 'ItemCode')
  final String itemCode;
  @JsonKey(name: 'RecptDesc')
  final String recptDesc;
  @JsonKey(name: 'UnitSellPrice')
  final String unitSellPrice;
  @JsonKey(name: 'ComboPack')
  final String comboPack;
  @JsonKey(name: 'WeightItem')
  final String weightItem;
  @JsonKey(name: 'OnPromotion')
  final String onPromotion;
  @JsonKey(name: 'PromoPrice')
  final String promoPrice;
  @JsonKey(name: 'Discountable')
  final String discountable;
  @JsonKey(name: 'Modifier')
  final String? modifierInt;
  @JsonKey(name: 'MasterCode')
  final String? masterCode;
  @JsonKey(name: 'Hidden')
  final String? hidden;
  @JsonKey(name: 'PromoCode')
  final String? promoCode;
  @JsonKey(name: 'PromoClass')
  final String? promoClass;
  @JsonKey(name: 'PkgPrice')
  final String? pkgPrice;
  @JsonKey(name: 'PkgQty')
  final String? pkgQty;
  @JsonKey(name: 'PkgItems')
  final String? pkgItems;
  @JsonKey(name: 'Blanket')
  final String? blanket;
  @JsonKey(name: 'Tax')
  final String? tax;

  @override
  List<Object> get props => [
        itemCode,
        recptDesc,
        unitSellPrice,
        comboPack,
        weightItem,
        onPromotion,
        promoPrice,
        discountable,
        modifierInt ?? '',
        masterCode ?? '',
        hidden ?? '',
        promoCode ?? '',
        promoClass ?? '',
        pkgPrice ?? '',
        pkgQty ?? '',
        pkgItems ?? '',
        blanket ?? '',
        tax ?? '',
      ];

  static const empty = Item(
      itemCode: '',
      recptDesc: '',
      unitSellPrice: '',
      comboPack: '',
      weightItem: '',
      onPromotion: '',
      promoPrice: '',
      discountable: '',
      modifierInt: '',
      masterCode: '',
      hidden: '',
      promoCode: '',
      promoClass: '',
      pkgPrice: '',
      pkgQty: '',
      pkgItems: '',
      blanket: '',
      tax: '' );

  const Item(
      {required this.itemCode,
      required this.recptDesc,
      required this.unitSellPrice,
      required this.comboPack,
      required this.weightItem,
      required this.onPromotion,
      required this.promoPrice,
      required this.discountable,
      required this.modifierInt,
      required this.masterCode,
      required this.hidden,
      required this.promoCode,
      required this.promoClass,
      required this.pkgPrice,
      required this.pkgQty,
      required this.pkgItems,
      required this.blanket,
      required this.tax });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
