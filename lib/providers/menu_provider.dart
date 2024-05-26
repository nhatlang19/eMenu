import 'soap_api_client.dart';

class MenuProvider extends SoapApiClient {
  MenuProvider();

  Future<List<dynamic>> getPosMenu(
    String posGroup,
  ) async {
    const String soapAction = 'http://tempuri.org/GetPOSMenu';
    final String soapBody = '''<GetPOSMenu xmlns="http://tempuri.org/">
                                <POSGroup>$posGroup</POSGroup>
                              </GetPOSMenu>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }

  Future<List<dynamic>> getSubMenu(
    String selectedPosMenu, String posGroup,
  ) async {
    const String soapAction = 'http://tempuri.org/GetSubMenu';
    final String soapBody = '''<GetSubMenu xmlns="http://tempuri.org/">
                                <selectedPOSMenu>$selectedPosMenu</selectedPOSMenu>
                                <POSGroup>$posGroup</POSGroup>
                              </GetSubMenu>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }
}
