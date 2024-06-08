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

  @override
  List<Object> get props => [itemCode, recptDesc, unitSellPrice, comboPack, weightItem, onPromotion, promoPrice, discountable];

  static const empty =
      Item(itemCode:'', recptDesc:'', unitSellPrice:'', comboPack:'', 
      weightItem:'', onPromotion:'', promoPrice:'', discountable:'');

  const Item({
    required this.itemCode, required this.recptDesc, required this.unitSellPrice, 
    required this.comboPack, required this.weightItem, required this.onPromotion, 
    required this.promoPrice, required this.discountable
  });

  factory Item.fromJson(Map<String, dynamic> json) => _$ItemFromJson(json);
}
