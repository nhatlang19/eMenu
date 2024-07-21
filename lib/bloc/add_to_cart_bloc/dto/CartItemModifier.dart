import 'package:emenu/models/item.dart';
import 'package:emenu/models/item_combo.dart';
import 'package:emenu/models/item_modifier.dart';

class CartItemModifier {
  ItemModifier itemModifier;
  int quantity = 1;

  CartItemModifier({required this.itemModifier, required this.quantity});
}