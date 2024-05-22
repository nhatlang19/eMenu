import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:xml/xml.dart' as xml;

import 'package:xml2json/xml2json.dart';

abstract class SoapApiClient {
  final String serviceUrl;

  SoapApiClient({required this.serviceUrl});

  Future<String?> callSoapService(String soapAction, String soapBody) async {
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

  List parseSoapResponseToJson(String response,
      {String element = "Table"}) {
    final document = xml.XmlDocument.parse(response);
    final elements = document.findAllElements(element);

    final List<dynamic>  jsonResult = [];
    final myTransformer = Xml2Json();

    elements.forEach((element) {
      myTransformer.parse(element.toXmlString());
      jsonResult.add(jsonDecode(myTransformer.toParker()));
    });
    return jsonResult;
  }

}
