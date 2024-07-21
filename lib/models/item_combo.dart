import 'package:equatable/equatable.dart';

import 'package:json_annotation/json_annotation.dart';

part 'item_combo.g.dart';

@JsonSerializable()
class ItemCombo extends Equatable {
  @JsonKey(name: 'ComboItem')
  final String? comboItem;
  @JsonKey(name: 'ItemDesc')
  final String? itemDesc;
  @JsonKey(name: 'Quantity')
  final String? quantity;
  @JsonKey(name: 'Hidden')
  final String? hidden;
  @JsonKey(name: 'ModClass')
  final String? modClass;
  @JsonKey(name: 'QtyEditable')
  final String? qtyEditable;

  @override
  List<Object> get props => [
        comboItem ?? '',
        itemDesc ?? '',
        quantity ?? '',
        hidden ?? '',
        modClass ?? '',
        qtyEditable ?? '',
      ];

  static const empty = ItemCombo(
      comboItem: '',
      itemDesc: '',
      quantity: '',
      hidden: '',
      modClass: '',
      qtyEditable: '');

  const ItemCombo(
      {required this.comboItem,
      required this.itemDesc,
      required this.quantity,
      required this.hidden,
      required this.modClass,
      required this.qtyEditable});

  factory ItemCombo.fromJson(Map<String, dynamic> json) =>
      _$ItemComboFromJson(json);
}
