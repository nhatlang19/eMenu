import 'package:emenu/bloc/add_to_cart_bloc/dto/CartItemCombo.dart';
import 'package:emenu/bloc/add_to_cart_bloc/dto/CartItemModifier.dart';
import 'package:emenu/models/item.dart';
import 'package:emenu/models/item_combo.dart';
import 'package:emenu/models/item_modifier.dart';

class CartItem {
  Item item;
  int qty = 0;
  String status = '';
  String instruction = '';
  int segNo = 0;
  double total = 0;
  double taxAmt = 0;
  late List<CartItemCombo> cartItemComboList;

  static const String SEPARATE = "|";

  static CartItem empty = CartItem(item: Item.empty, qty: 0, segNo: 0);

  CartItem({required this.item, required this.qty, this.segNo = 0}) {
    updateData();
    cartItemComboList = [];
  }

  String getTitle() {
    String titles = '';
    for (CartItemCombo item in cartItemComboList) {
      titles += '${item.itemCombo.itemDesc},';
    }

    return titles;
  }

  void updateData() {
    total = (double.parse(item.unitSellPrice) * qty) -
        double.parse(item.promoPrice);
    taxAmt = (total * double.parse(item.tax ?? '0')) / 100;
  }

  List<CartItem> convertChildToCartItems() {
    List<CartItem> cartItems = [];
    for (CartItemCombo cartItemCombo in cartItemComboList) {
      ItemCombo itemCombo = cartItemCombo.itemCombo;
      for (CartItemModifier cartItemModifier in cartItemCombo.cartItemModifierList) {
        ItemModifier itemModifier = cartItemModifier.itemModifier;
        Item item = Item(
            itemCode: itemModifier.itemCode ?? '',
            recptDesc: '*${itemModifier.modDesc ?? ''}',
            itemType: 'M',
            unitSellPrice: itemModifier.unitPrice ?? '0',
            comboPack: itemCombo.modClass ?? '',
            weightItem: '',
            onPromotion: '',
            promoPrice: '0',
            discountable: '',
            modifierInt: itemModifier.modCode,
            masterCode: itemModifier.itemCode ?? '',
            hidden: itemCombo.hidden,
            promoCode: '',
            promoClass: '',
            pkgPrice: '',
            pkgQty: '',
            pkgItems: '',
            blanket: '',
            tax: '');

        cartItems.add(CartItem(item: item, qty: cartItemModifier.quantity));
      }
    }

    return cartItems;
  }

  String toString() {
    String result = "";
    result += qty.toString() + SEPARATE;
    result += status + SEPARATE;
    result += item.recptDesc + SEPARATE; // itemName
    result += item.unitSellPrice + SEPARATE; // orgPrice
    result += item.promoPrice + SEPARATE;
    result += total.toString() + SEPARATE;
    result += (item.itemType ?? '') + SEPARATE; //itemType
    result += item.itemCode + SEPARATE;
    result += (item.modifierInt ?? '') + SEPARATE;
    result += (item.masterCode ?? '') + SEPARATE;
    result += item.comboPack + SEPARATE;
    result += (item.hidden ?? '') + SEPARATE;
    result += instruction + SEPARATE;
    result += segNo.toString() + SEPARATE;
    result += (item.promoCode ?? '') + SEPARATE;
    result += (item.promoClass ?? '') + SEPARATE;
    result += (item.pkgPrice ?? '') + SEPARATE;
    result += (item.pkgQty ?? '') + SEPARATE;
    result += (item.pkgItems ?? '') + SEPARATE;
    result += (item.blanket ?? '') + SEPARATE;
    result += (item.tax ?? '') + SEPARATE;
    result += taxAmt.toString();
    return result;
  }
}
