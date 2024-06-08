import 'dart:async';

import 'package:emenu/models/item.dart';
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
}
