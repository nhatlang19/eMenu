import 'dart:convert';

import 'package:emenu/utils/global.dart';
import 'package:emenu/utils/settings.dart';
import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;
import 'package:xml2json/xml2json.dart';

abstract class SoapApiClient {
  SoapApiClient();

  void printLongString(String text) {
    const int chunkSize = 800; // Adjust chunk size based on your needs
    for (int i = 0; i < text.length; i += chunkSize) {
      print(text.substring(i, i + chunkSize > text.length ? text.length : i + chunkSize));
    }
  }

  Future<String> getServiceUrl() async {
    var settings = Settings();
    var setting = await settings.read();
    var serverIp = setting.serverIP;
    return Global.serviceUrl(serverIp);
  }

  Future<String?> callSoapServiceLargeData(String soapAction, String soapBody) async {
    final String soapEnvelope = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        $soapBody
      </soap:Body>
    </soap:Envelope>''';

    var serviceUrl = await getServiceUrl();
    final response = await http.post(
      Uri.parse(serviceUrl),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction': soapAction,
      },
      body: soapEnvelope,
    ).timeout(const Duration(minutes: 5));
    if (response.statusCode == 200) {
      return response.body;
    } else {
      // print('Failed with status code:  ${response.statusCode}  ${response.reasonPhrase} ${response.body}');
      return null;
    }
  }

  Future<String?> callSoapService(String soapAction, String soapBody) async {
    final String soapEnvelope = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        $soapBody
      </soap:Body>
    </soap:Envelope>''';

    var serviceUrl = await getServiceUrl();
    final response = await http.post(
      Uri.parse(serviceUrl),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction': soapAction,
      },
      body: soapEnvelope,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  Future<String?> callSoapServiceWithServiceUrl(String soapAction, String soapBody, String serviceUrl) async {
    final String soapEnvelope = '''<?xml version="1.0" encoding="utf-8"?>
    <soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
      <soap:Body>
        $soapBody
      </soap:Body>
    </soap:Envelope>''';

    final response = await http.post(
      Uri.parse(serviceUrl),
      headers: {
        'Content-Type': 'text/xml; charset=utf-8',
        'SOAPAction': soapAction
      },
      body: soapEnvelope,
    );

    if (response.statusCode == 200) {
      return response.body;
    } else {
      return null;
    }
  }

  List parseSoapResponseToJson(String response, {String element = "Table"}) {
    final document = xml.XmlDocument.parse(response);
    final elements = document.findAllElements(element);

    final List<dynamic>  jsonResult = [];
    final myTransformer = Xml2Json();

    for (var elm in elements) {
      myTransformer.parse(elm.toXmlString());
      jsonResult.add(jsonDecode(myTransformer.toParker()));
    }
    return jsonResult;
  }

  dynamic parseSoapResponseToOneValue(String response, {String element = "Table"}) {
    final document = xml.XmlDocument.parse(response);
    return document.findAllElements(element).first.innerText;
  }
}
