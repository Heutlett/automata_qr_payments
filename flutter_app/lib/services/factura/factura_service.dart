import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/models/comprobante_summary.dart';
import 'package:flutter_app/models/server_response.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter_app/utils/config.dart';

const String selectedHost = "facturas_api";

Future<http.Response> postAddComprobante(Object? factura) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  print(jsonEncode(factura));

  var responseAddComprobante = await http.post(
    Uri.parse('https://$host/api/Comprobante/comprobantes/add'),
    body: jsonEncode(factura),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );
  return responseAddComprobante;
}

Future<ServerResponse<List<ComprobanteSummary>>> getComprobanteSummary(
    int id) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var url = "https://$host/api/Comprobante/comprobantes/summary/$id";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  ServerResponse<List<ComprobanteSummary>> serverResponse;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    if (data['success']) {
      data = data['data'];

      List<ComprobanteSummary> comprobantesSummaryList = [];

      for (int i = 0; i < data.length; i++) {
        comprobantesSummaryList.add(
          ComprobanteSummary(
            id: data[i]['id'],
            estado: data[i]['estado'],
            descripcion: data[i]['descripcion'],
            numeroConsecutivo: data[i]['numeroConsecutivo'],
            fechaEmision: DateTime.parse(data[i]['fechaEmision']),
            codigoMonedaId: data[i]['codigoMonedaId'],
            totalComprobante: data[i]['totalComprobante'],
          ),
        );
      }

      serverResponse = ServerResponse(
          data: comprobantesSummaryList, message: '', success: true);
    } else {
      serverResponse =
          ServerResponse(data: null, message: data['message'], success: true);
    }
  } else {
    serverResponse = ServerResponse(
        data: null,
        message: 'Ha ocurrido un error, probablemente el token ha expirado',
        success: false);
  }

  return serverResponse;
}
