import 'soap_api_client.dart';

class UserProvider extends SoapApiClient {
  UserProvider();

  Future<Map<String, dynamic>?> loginAction(String username, String password) async {
    const String soapAction = 'http://tempuri.org/GetUser';
    final String soapBody = '''<GetUser xmlns="http://tempuri.org/">
                                <username>$username</username>
                                <password>$password</password>
                              </GetUser>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      final jsonResult = parseSoapResponseToJson(response);
      return jsonResult.first['Table'] as Map<String, dynamic>;
    }
    return null;
  }

  Future<List<dynamic>> getUserList() async {
    const String soapAction = 'http://tempuri.org/GetUserList';
    const String soapBody =
        '''<GetUserList xmlns="http://tempuri.org/" />''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }
}