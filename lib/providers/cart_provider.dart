import 'soap_api_client.dart';

class CartProvider extends SoapApiClient {
  CartProvider();

  Future<bool> sendOrder(
      String dataTableString, String sendNewOrder, String reSendOrder, String typeLoad,
      String posNo, String orderNo, String extNo, String splited, String currTable,
      String POSBizDate, String currTableGroup, String noOfPerson, String salesCode, String cashierID) async {
    const String soapAction = 'http://tempuri.org/SendOrder';
    final String soapBody =
        '''<SendOrder xmlns="http://tempuri.org/">
            <dataTableString>$dataTableString</dataTableString>
            <SendNewOrder>$sendNewOrder</SendNewOrder>
            <ReSendOrder>$reSendOrder</ReSendOrder>
            <typeLoad>$typeLoad</typeLoad>
            <posNo>$posNo</posNo>
            <orderNo>$orderNo</orderNo>
            <extNo>$extNo</extNo>
            <splited>$splited</splited>
            <currTable>$currTable</currTable>
            <POSBizDate>$POSBizDate</POSBizDate>
            <currTableGroup>$currTableGroup</currTableGroup>
            <noOfPerson>$noOfPerson</noOfPerson>
            <salesCode>$salesCode</salesCode>
            <cashierID>$cashierID</cashierID>
          </SendOrder>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToOneValue(response, element: "SendOrderResult") == 'true';
    }
    return false;
  }

  Future<dynamic?> getNewOrderNumberByPOS(String posNo) async {
    const String soapAction = 'http://tempuri.org/GetNewOrderNumberByPOS';
    final String soapBody =
        '''<GetNewOrderNumberByPOS xmlns="http://tempuri.org/">
            <POSId>$posNo</POSId>
          </GetNewOrderNumberByPOS>''';

    final response = await callSoapService(soapAction, soapBody);
    if (response != null) {
      return parseSoapResponseToOneValue(response, element: "GetNewOrderNumberByPOSResult");
    }
    return null;
  }

    Future<List<dynamic>> getEditOrderNumberByPOS(String orderNo, String posNo, String extNo) async {
    const String soapAction = 'http://tempuri.org/GetEditOrderNumberByPOS';
    final String soapBody = '''<GetEditOrderNumberByPOS xmlns="http://tempuri.org/">
                                <orderNo>$orderNo</orderNo>
                                <posNo>$posNo</posNo>
                                <extNo>$extNo</extNo>
                              </GetEditOrderNumberByPOS>''';

    final response = await callSoapService(soapAction, soapBody);
    print(response);
    if (response != null) {
      return parseSoapResponseToJson(response);
    }
    return [];
  }
}
