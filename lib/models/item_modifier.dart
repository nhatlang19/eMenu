import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'item_modifier.g.dart';

@JsonSerializable()
class ItemModifier extends Equatable {
  @JsonKey(name: 'ItemCode')
  final String? itemCode;
  @JsonKey(name: 'ModCode')
  final String? modCode;
  @JsonKey(name: 'Quantity')
  final String? quantity;
  @JsonKey(name: 'ModDesc')
  final String? modDesc;
  @JsonKey(name: 'UnitPrice')
  final String? unitPrice;

  @override
  List<Object> get props => [
        itemCode ?? '',
        modCode ?? '',
        quantity ?? '',
        modDesc ?? '',
        unitPrice ?? '',
      ];

  static const empty = ItemModifier(
      itemCode: '',
      modCode: '',
      quantity: '',
      modDesc: '',
      unitPrice: '');

  const ItemModifier(
      {required this.itemCode,
      required this.modCode,
      required this.quantity,
      required this.modDesc,
      required this.unitPrice});

  factory ItemModifier.fromJson(Map<String, dynamic> json) =>
      _$ItemModifierFromJson(json);
}
