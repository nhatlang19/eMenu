import 'dart:async';

import 'package:emenu/models/item.dart';
import 'package:emenu/models/item_combo.dart';
import 'package:emenu/models/item_modifier.dart';
import 'package:emenu/providers/item_provider.dart';


class ItemRepository {
  Future<Item> getItemBySubMenuSelected({
    required String currSubItem,
    required String priceLevel,
    required int qty
  }) async {
    final provider = ItemProvider();

    var json = await provider.getItemBySubMenuSelected(currSubItem, priceLevel, qty);

    final List<Item> result = [];
    json.forEach((data) {
      result.add(Item.fromJson(data['Table1'] as Map<String, dynamic>));
    });
     
    return result[0];
  }

  Future<List<ItemCombo>> getItemComboBySubMenuSelected({required String currSubItem}) async {
    final provider = ItemProvider();

    var json = await provider.getItemComboBySubMenuSelected(currSubItem);

    final List<ItemCombo> result = [];
    json.forEach((data) {
      result.add(ItemCombo.fromJson(data['Table'] as Map<String, dynamic>));
    });
     
    return result;
  }

  Future<List<ItemModifier>> getModifierByModifierItem ({required String modifierItem}) async {
    final provider = ItemProvider();

    var json = await provider.getModifierByModifierItem(modifierItem);

    final List<ItemModifier> result = [];
    json.forEach((data) {
      result.add(ItemModifier.fromJson(data['Table'] as Map<String, dynamic>));
    });
     
    return result;
  }
}
