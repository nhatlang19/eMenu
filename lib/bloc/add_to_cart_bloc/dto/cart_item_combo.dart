import 'package:emenu/bloc/add_to_cart_bloc/dto/cart_item_modifier.dart';
import 'package:emenu/models/item_combo.dart';
import 'package:emenu/models/item_modifier.dart';

class CartItemCombo {
  ItemCombo itemCombo;
  List<CartItemModifier> cartItemModifierList;
  int maxQuantity = 0;

  CartItemCombo({required this.itemCombo, required this.cartItemModifierList, int qty = 1}) {
    maxQuantity = (qty * double.parse(itemCombo.quantity ?? "0")).toInt();
  }

  void initFromItemModifiers(List<ItemModifier> itemModifiers) {
    int index = 0;
    for (var itemModifier in itemModifiers) {
      var hasDefaultValue = index == 0;
      cartItemModifierList.add(CartItemModifier(itemModifier: itemModifier, hasDefaultValue: hasDefaultValue));
      index++;
    }
  }

  int getValue(CartItemModifier cartItemModifier) {
    int value = cartItemModifier.quantity;
   
    // if (value == 0 && cartItemModifier.hasDefaultValue) {
    //     return maxQuantity;
    // }
    return value;
  }

  String isValid() {
    int n = cartItemModifierList.length;
		int count = 0;
		for (int i = 0; i < n; i++) {
			CartItemModifier row = cartItemModifierList[i];
			count += getValue(row);
		}

    String errorMessage = "";
    var allowEdit = itemCombo.qtyEditable == 'Y';
    String tmpMsg = "Quantity Item ${itemCombo.itemDesc.toString()} must be";
    if (allowEdit) {
      if (count > maxQuantity) {
        errorMessage = "$tmpMsg <= $maxQuantity";
      }
    } else {
      if (count != maxQuantity) {
        errorMessage = "$tmpMsg = $maxQuantity";
      }
    }
    return errorMessage;
  }
}
