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

  Future<List<dynamic>> getTableListAllSection() async {
    const String soapAction = 'http://tempuri.org/GetTableListAllSection';
    final String soapBody =
        '''<GetTableListAllSection xmlns="http://tempuri.org/">
           </GetTableListAllSection>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }

  Future<List<dynamic>> getStatusOfMoveTable(String moveTable) async {
    const String soapAction = 'http://tempuri.org/GetStatusOfMoveTable';
    final String soapBody =
        '''<GetStatusOfMoveTable xmlns="http://tempuri.org/">
            <moveTable>$moveTable</moveTable>
           </GetStatusOfMoveTable>''';

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

  Future<bool> moveTable(
      String currTable, String moveTable, String currTableGroup,
      String posNo, String orderNo, String extNo, String splited, String cashierId) async {
    const String soapAction = 'http://tempuri.org/MoveTable';
    final String soapBody =
        '''<MoveTable xmlns="http://tempuri.org/">
            <currTable>$currTable</currTable>
            <moveTable>$moveTable</moveTable>
            <currTableGroup>$currTableGroup</currTableGroup>
            <posNo>$posNo</posNo>
            <orderNo>$orderNo</orderNo>
            <extNo>$extNo</extNo>
            <splited>$splited</splited>
            <cashierId>$cashierId</cashierId>
          </MoveTable>''';

    final response = await callSoapServiceLargeData(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToOneValue(response, element: "MoveTableResult") == 'OK';
    }
    return false;
  }
}
