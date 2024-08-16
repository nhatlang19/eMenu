import 'soap_api_client.dart';

class OrderProvider extends SoapApiClient {
  OrderProvider();

  Future<List<dynamic>> getOrderEditType(
    String posBizDate, String currentTable
  ) async {
    const String soapAction = 'http://tempuri.org/GetOrderEditType';
    final String soapBody = '''<GetOrderEditType xmlns="http://tempuri.org/">
                                <POSBizDate>$posBizDate</POSBizDate>
                                <currentTable>$currentTable</currentTable>
                              </GetOrderEditType>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }
}
