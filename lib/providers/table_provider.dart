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
}
