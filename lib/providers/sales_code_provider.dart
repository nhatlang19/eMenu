import 'soap_api_client.dart';

class SalesCodeProvider extends SoapApiClient {
  SalesCodeProvider();

  Future<List<dynamic>> getSalesCode() async {
    const String soapAction = 'http://tempuri.org/GetSalesCode';
    const String soapBody =
        '''<GetSalesCode xmlns="http://tempuri.org/" />''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }
}
