import 'dart:async';

import 'package:emenu/models/order.dart';
import 'package:emenu/providers/cart_provider.dart';
import 'package:emenu/providers/order_provider.dart';


class OrderRepository {
  Future<List<Order>> getOrderEditType({
    required String posBizDate, required String currentTable
  }) async {
    final provider = OrderProvider();

    var json = await provider.getOrderEditType(posBizDate, currentTable);
    final List<Order> result = [];
    for (var data in json) {
      result.add(Order.fromJson(data['Table'] as Map<String, dynamic>));
    }
     
    return result;
  }

  Future<String> getNewOrderNumberByPOS(String posNo) async {
    final provider = CartProvider();

    final response = await provider.getNewOrderNumberByPOS(posNo);
    if (response != null) {
      return response + "";
    }
    return "";
  }
}
