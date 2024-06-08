import 'package:emenu/models/item.dart';

class CartItem {
  Item item;
  int qty = 0;

  CartItem({required this.item, required this.qty});
}