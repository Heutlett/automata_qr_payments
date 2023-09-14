import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/constants/endpoints.dart';
import 'package:flutter_app/managers/shared_local_store.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/models/comprobante.dart';
import 'package:flutter_app/models/comprobante_summary.dart';
import 'package:flutter_app/models/server_response.dart';
import 'package:http/http.dart' as http;

Future<http.Response> postAddComprobante(Object? factura) async {
  String token = await SharedLocalStore.getAccessToken();

  var responseAddComprobante = await http.post(
    Uri.parse(postComprobanteUrl),
    body: jsonEncode(factura),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );
  return responseAddComprobante;
}

Future<ServerResponse<List<ComprobanteSummary>>> getComprobantesSummary(
    int id) async {
  String token = await SharedLocalStore.getAccessToken();

  var url = "$getComprobantesSummaryUrl/$id";
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

Future<ServerResponse<Comprobante>> getComprobante(int id) async {
  String token = await SharedLocalStore.getAccessToken();

  var url = "$getComprobanteDetailsUrl/$id";
  var headers = {"Authorization": "bearer $token"};
  var response = await http.get(Uri.parse(url), headers: headers);

  ServerResponse<Comprobante> serverResponse;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    if (data['success']) {
      data = data['data'];

      Account accountEmisor = Account(
        id: data['cuentaEmisor']['id'].toString(),
        cedulaTipo: data['cuentaEmisor']['cedulaTipo'],
        cedulaNumero: data['cuentaEmisor']['cedulaNumero'],
        idExtranjero: data['cuentaEmisor']['idExtranjero'],
        nombre: data['cuentaEmisor']['nombre'],
        nombreComercial: data['cuentaEmisor']['nombreComercial'],
        telCodigoPais: data['cuentaEmisor']['telCodigoPais'],
        telNumero: data['cuentaEmisor']['telNumero'],
        faxCodigoPais: data['cuentaEmisor']['faxCodigoPais'],
        faxNumero: data['cuentaEmisor']['faxNumero'],
        correo: data['cuentaEmisor']['correo'],
        ubicacionCodigo: data['cuentaEmisor']['ubicacionCodigo'],
        ubicacionSenas: data['cuentaEmisor']['ubicacionSenas'],
        ubicacionSenasExtranjero: data['cuentaEmisor']
            ['ubicacionSenasExtranjero'],
        tipo: data['cuentaEmisor']['tipo'],
        actividades: [],
        esCompartida: data['cuentaEmisor']['esCompartida'],
        usuariosCompartidos: [],
      );

      Account accountReceptor = Account(
        id: data['cuentaReceptor']['id'].toString(),
        cedulaTipo: data['cuentaReceptor']['cedulaTipo'],
        cedulaNumero: data['cuentaReceptor']['cedulaNumero'],
        idExtranjero: data['cuentaReceptor']['idExtranjero'],
        nombre: data['cuentaReceptor']['nombre'],
        nombreComercial: data['cuentaReceptor']['nombreComercial'],
        telCodigoPais: data['cuentaReceptor']['telCodigoPais'],
        telNumero: data['cuentaReceptor']['telNumero'],
        faxCodigoPais: data['cuentaReceptor']['faxCodigoPais'],
        faxNumero: data['cuentaReceptor']['faxNumero'],
        correo: data['cuentaReceptor']['correo'],
        ubicacionCodigo: data['cuentaReceptor']['ubicacionCodigo'],
        ubicacionSenas: data['cuentaReceptor']['ubicacionSenas'],
        ubicacionSenasExtranjero: data['cuentaReceptor']
            ['ubicacionSenasExtranjero'],
        tipo: data['cuentaReceptor']['tipo'],
        actividades: [],
        esCompartida: data['cuentaReceptor']['esCompartida'],
        usuariosCompartidos: [],
      );

      var comprobante = Comprobante(
        id: data['id'],
        estado: data['estado'],
        descripcion: data['descripcion'],
        numeroConsecutivo: data['numeroConsecutivo'],
        fechaEmision: DateTime.parse(data['fechaEmision']),
        codigoMoneda: data['codigoMoneda'],
        totalComprobante: data['totalComprobante'],
        clave: data['clave'],
        codigoActividad: data['codigoActividad'],
        condicionVenta: data['condicionVenta'],
        medioPago: data['medioPago'],
        totalDescuentos: data['totalDescuentos'],
        totalImpuesto: data['totalImpuesto'],
        totalVenta: data['totalVenta'],
        cuentaEmisor: accountEmisor,
        cuentaReceptor: accountReceptor,
      );

      serverResponse =
          ServerResponse(data: comprobante, message: '', success: true);
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
