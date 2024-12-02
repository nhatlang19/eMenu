import 'soap_api_client.dart';

class TableProvider extends SoapApiClient {
  TableProvider();

  Future<List<dynamic>> getTableListBySection(
    String section,
  ) async {
    const String soapAction = 'http://tempuri.org/GetTableListBySection';
    final String soapBody =
        '''<GetTableListBySection xmlns="http://tempuri.org/">
                                <section>$section</section>
                              </GetTableListBySection>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }

  Future<bool> updateTableStatus(String status, String cashierId, String currentTable) async {
    const String soapAction = 'http://tempuri.org/UpdateTableStatus';
    final String soapBody =
        '''<UpdateTableStatus xmlns="http://tempuri.org/">
            <tableStatus>$status</tableStatus>
            <cashierID>$cashierId</cashierID>
            <currentTable>$currentTable</currentTable>
          </UpdateTableStatus>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToOneValue(response, element: "UpdateTableStatusResult") == 'true';
    }
    return false;
  }
}
