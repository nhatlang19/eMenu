import 'package:emenu/models/item.dart';

class CartItem {
  Item item;
  int qty = 0;
  String status = '';
  String instruction = '';
  int segNo = 0;
  double total = 0;
  double taxAmt = 0;

  static const String SEPARATE = "|";

  CartItem({required this.item, required this.qty, required this.segNo}) {
    updateData();
  }

  Future<void> updateData() async {
    total = (double.parse(item.unitSellPrice) * qty) - double.parse(item.promoPrice);
    taxAmt = (total * double.parse(item.tax ?? '0')) / 100;
  }

	String toString() {
		String result = "";
		result += qty.toString() + SEPARATE;
		result += status + SEPARATE;
		result += item.recptDesc + SEPARATE; // itemName
		result += item.unitSellPrice + SEPARATE; // orgPrice
		result += item.promoPrice + SEPARATE;
		result += total.toString() + SEPARATE;
		result += item.comboPack + SEPARATE; //itemType
		result += item.itemCode + SEPARATE;
		result += (item.modifierInt ?? '' ) + SEPARATE;
		result += (item.masterCode ?? '' ) + SEPARATE;
		result += item.comboPack + SEPARATE;
		result += (item.hidden ?? '' ) + SEPARATE;
		result += instruction + SEPARATE;
		result += segNo.toString() + SEPARATE;
		result += (item.promoCode ?? '' ) + SEPARATE;
		result += (item.promoClass ?? '' ) + SEPARATE;
		result += (item.pkgPrice ?? '' )  + SEPARATE;
		result += (item.pkgQty ?? '' )  + SEPARATE;
		result += (item.pkgItems ?? '' )  + SEPARATE;
		result += (item.blanket ?? '' ) + SEPARATE;
		result += (item.tax ?? '' ) + SEPARATE;
		result += taxAmt.toString();
		return result;
	}
}