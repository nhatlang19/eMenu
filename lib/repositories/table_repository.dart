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
    json.forEach((data) {
      result.add(Table.fromJson(data['Table'] as Map<String, dynamic>));
    });
     
    return result;
  }
}
