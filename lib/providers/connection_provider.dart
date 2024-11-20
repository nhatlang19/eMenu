import 'soap_api_client.dart';

class ConnectionProvider extends SoapApiClient {
  ConnectionProvider();

  Future<dynamic> checkConnection(String serviceUrl) async {
    const String soapAction = 'http://tempuri.org/IsSQLConnected';
    const String soapBody =
        '''<IsSQLConnected xmlns="http://tempuri.org/" />''';

    final response = await callSoapServiceWithServiceUrl(soapAction, soapBody, serviceUrl);
    if (response != null) {
      return parseSoapResponseToOneValue(response, element: "IsSQLConnectedResult");
    }
    return null;
  }
}
