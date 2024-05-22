import 'soap_api_client.dart';

class UserProvider extends SoapApiClient {
  UserProvider({required super.serviceUrl});

  Future<List?> loginAction(String username, String password) async {
    const String soapAction = 'http://tempuri.org/GetUser';
    final String soapBody = '''<GetUser xmlns="http://tempuri.org/">
                                <username>$username</username>
                                <password>$password</password>
                              </GetUser>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return null;
  }
}