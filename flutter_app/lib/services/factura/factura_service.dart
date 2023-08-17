import 'dart:async';
import 'dart:convert';
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
