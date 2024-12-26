import 'dart:convert';

import 'package:json_annotation/json_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

@JsonSerializable()
class TableAuditData {
  final String status;
  final String cashierId;
  final String currentTable;

  const TableAuditData(
      {required this.status,
      required this.cashierId,
      required this.currentTable,
  });

  static const empty = TableAuditData(status: '', cashierId: '', currentTable: '');

  factory TableAuditData.fromJson(Map<String, dynamic> json) {
    return TableAuditData(
      status: json['status'],
      cashierId: json['cashierId'],
      currentTable: json['currentTable'],
    );
  }

  Map<String, dynamic> toJson() => {
        'status': status,
        'cashierId': cashierId,
        'currentTable': currentTable,
      };
}

class TableAudit {
  Future<void> write(TableAuditData data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String json = jsonEncode(data.toJson());
    prefs.setString('tableAudit', json);
  }

  Future<TableAuditData> read() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
     final String? json = prefs.getString('tableAudit');
    if (json != null) {
      return TableAuditData.fromJson(jsonDecode(json) as Map<String, dynamic>);
    }

    return TableAuditData.empty;
  }
}
