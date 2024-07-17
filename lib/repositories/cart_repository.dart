import 'dart:async';

import 'package:emenu/providers/cart_provider.dart';

class CartRepository {
  Future<String?> sendOrder(
      {required String dataTableString,
      required String sendNewOrder,
      required String reSendOrder,
      required String typeLoad,
      required String posNo,
      required String orderNo,
      required String extNo,
      required String splited,
      required String currTable,
      required String POSBizDate,
      required String currTableGroup,
      required String noOfPerson,
      required String salesCode,
      required String cashierID}) async {
    final provider = CartProvider();

    var res = await provider.sendOrder(
        dataTableString,
        sendNewOrder,
        reSendOrder,
        typeLoad,
        posNo,
        orderNo,
        extNo,
        splited,
        currTable,
        POSBizDate,
        currTableGroup,
        noOfPerson,
        salesCode,
        cashierID);

    return res;
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
