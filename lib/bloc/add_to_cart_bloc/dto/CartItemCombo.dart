import 'package:emenu/bloc/add_to_cart_bloc/dto/CartItemModifier.dart';
import 'package:emenu/models/item_combo.dart';
import 'package:emenu/models/item_modifier.dart';

class CartItemCombo {
  ItemCombo itemCombo;
  List<CartItemModifier> cartItemModifierList;

  CartItemCombo({required this.itemCombo, required this.cartItemModifierList});

  void initFromItemModifiers(List<ItemModifier> itemModifiers) {
    for (var itemModifier in itemModifiers) {
      cartItemModifierList.add(CartItemModifier(
          itemModifier: itemModifier,
          quantity: 1));
    }
  }
}
