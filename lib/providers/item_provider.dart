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

  Future<List<dynamic>> getItemComboBySubMenuSelected(
      String currSubItem) async {
    const String soapAction =
        'http://tempuri.org/GetItemComboBySubMenuSelected';
    final String soapBody =
        '''<GetItemComboBySubMenuSelected xmlns="http://tempuri.org/">
            <currSubItem>$currSubItem</currSubItem>
          </GetItemComboBySubMenuSelected>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response, element: "Table");
    }
    return [];
  }

  Future<List<dynamic>> getModifierByModifierItem(String modifierItem) async {
    const String soapAction = 'http://tempuri.org/GetModifierByModifierItem';
    final String soapBody =
        '''<GetModifierByModifierItem xmlns="http://tempuri.org/">
            <modifierItem>$modifierItem</modifierItem>
          </GetModifierByModifierItem>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToJson(response, element: "Table");
    }
    return [];
  }
}
