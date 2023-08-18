import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/models/comprobante_summary.dart';
import 'package:flutter_app/models/server_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app/utils/config.dart';

const String selectedHost = "host_adrian_sanvito";

Future<http.Response> postAddComprobante(Object? factura) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var responseAddComprobante = await http.post(
    Uri.parse('http://$host/api/Comprobante/comprobantes/add'),
    body: jsonEncode(factura),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );
  return responseAddComprobante;
}

Future<ServerResponse<ComprobanteSummary>> getComprobanteSummary(int id) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var url = "http://$host/api/Comprobante/comprobantes/summary/$id";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  var data = jsonDecode(response.body);

  print(data);

  return data;
}
