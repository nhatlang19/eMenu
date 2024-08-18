import 'package:emenu/models/item_modifier.dart';

class CartItemModifier {
  ItemModifier itemModifier;
  int quantity = 0;
  bool hasDefaultValue = false;

  CartItemModifier({required this.itemModifier, this.hasDefaultValue = false}) {
    quantity = 0;
    if (hasDefaultValue) {
      quantity = double.parse(itemModifier.quantity ?? '0').toInt();
    }
  }
}