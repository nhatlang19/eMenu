import 'soap_api_client.dart';

class SectionProvider extends SoapApiClient {
  SectionProvider();

  Future<List<dynamic>> getSection(
    String section,
  ) async {
    const String soapAction = 'http://tempuri.org/GetSection';
    final String soapBody =
        '''<GetSection xmlns="http://tempuri.org/">
                                <section>$section</section>
                              </GetSection>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }
}
