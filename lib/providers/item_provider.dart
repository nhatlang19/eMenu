import 'soap_api_client.dart';

class ItemProvider extends SoapApiClient {
  ItemProvider();

  Future<List<dynamic>> getItemBySubMenuSelected(
      String currSubItem, String priceLevel, int qty) async {
    const String soapAction = 'http://tempuri.org/GetItemBySubMenuSelected';
    final String soapBody =
        '''<GetItemBySubMenuSelected xmlns="http://tempuri.org/">
            <currSubItem>$currSubItem</currSubItem>
            <priceLevel>$priceLevel</priceLevel>
            <qty>$qty</qty>
          </GetItemBySubMenuSelected>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response, element: "Table1");
    }
    return [];
  }
}
