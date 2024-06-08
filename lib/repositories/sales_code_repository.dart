import 'dart:async';

import 'package:emenu/models/sales_code.dart';
import 'package:emenu/providers/sales_code_provider.dart';


class SalesCodeRepository {
  Future<List<SalesCode>> getSalesCode() async {
    final provider = SalesCodeProvider();

    var json = await provider.getSalesCode();
    final List<SalesCode> result = [];
    json.forEach((json) {
      result.add(SalesCode.fromJson(json['Table'] as Map<String, dynamic>));
    });
     
    return result;
  }
}
