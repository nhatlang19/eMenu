import 'package:emenu/models/item_modifier.dart';

class CartItemModifier {
  ItemModifier itemModifier;
  int quantity = 0;
  bool hasDefaultValue = false;

  CartItemModifier({required this.itemModifier, this.quantity = 0, this.hasDefaultValue = false});
}