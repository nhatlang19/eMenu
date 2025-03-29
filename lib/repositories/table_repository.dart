import 'dart:async';

import 'package:emenu/models/table.dart';
import 'package:emenu/providers/table_provider.dart';


enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class TableRepository {
  Future<List<Table>> getTableListBySection({
    required String section
  }) async {
    final provider = TableProvider();

    var json = await provider.getTableListBySection(section);

    final List<Table> result = [];
    for (var data in json) {
      result.add(Table.fromJson(data['Table'] as Map<String, dynamic>));
    }
     
    return result;
  }

  Future<List<Table>> getTableListAllSection() async {
    final provider = TableProvider();

    var json = await provider.getTableListAllSection();

    final List<Table> result = [];
    for (var data in json) {
      result.add(Table.fromJson(data['Table'] as Map<String, dynamic>));
    }
     
    return result;
  }

  Future<Table> getStatusOfMoveTable({required String moveTable}) async {
    final provider = TableProvider();

    var json = await provider.getStatusOfMoveTable(moveTable);
    final List<Table> result = [];
    for (var data in json) {
      result.add(Table.fromJson(data['Table'] as Map<String, dynamic>));
    }

    return result[0];
  }

  Future<bool> moveTable(
      {required String currTable,
      required String moveTable,
      required String currTableGroup,
      required String posNo,
      required String orderNo,
      required String extNo,
      required String splited,
      required String cashierID}) async {
    final provider = TableProvider();

    var res = await provider.moveTable(
        currTable,
        moveTable,
        currTableGroup,
        posNo,
        orderNo,
        extNo,
        splited,
        cashierID);

    return res;
  }

  Future<bool> updateTableStatus({required String status
  , required String cashierId
  , required String currentTable}) async {
    final provider = TableProvider();

    var res = await provider.updateTableStatus(status, cashierId, currentTable);

    return res;
  }
}
