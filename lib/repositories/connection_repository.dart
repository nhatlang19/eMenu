import 'dart:async';

import 'package:emenu/models/item.dart';
import 'package:emenu/providers/connection_provider.dart';

class ConnectionRepository {
  Future<bool> checkConnection(String serviceUrl) async {
    final provider = ConnectionProvider();

    final response = await provider.checkConnection(serviceUrl);
    if (response != null) {
      return response + "" == 'true';
    }
    return false;
  }
}
