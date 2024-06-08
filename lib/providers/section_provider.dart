import 'soap_api_client.dart';

class SectionProvider extends SoapApiClient {
  SectionProvider();

  Future<List<dynamic>> getSection() async {
    const String soapAction = 'http://tempuri.org/GetSection';
    const String soapBody =
        '''<GetSection xmlns="http://tempuri.org/" />''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }
}
