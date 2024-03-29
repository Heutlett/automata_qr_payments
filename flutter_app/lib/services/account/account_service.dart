import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/constants/endpoints.dart';
import 'package:flutter_app/managers/shared_local_store.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_app/models/account.dart';

import 'package:flutter_app/models/actividad.dart';
import 'package:flutter_app/models/server_response.dart';
import 'package:flutter_app/models/ubicacion.dart';

Future<http.Response> postCreateAccount(Object? cuenta) async {
  String token = await SharedLocalStore.getAccessToken();

  var responseCreateAcc = await http.post(
    Uri.parse(accountManagementUrl),
    body: jsonEncode(cuenta),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );
  return responseCreateAcc;
}

Future<http.Response> putEditAccount(String id, Object? cuenta) async {
  String token = await SharedLocalStore.getAccessToken();

  print(jsonEncode(cuenta));

  var responseCreateAcc = await http.put(
    Uri.parse(accountManagementUrl),
    body: jsonEncode(cuenta),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );
  return responseCreateAcc;
}

Future<http.Response> deleteOwnAccount(String id) async {
  String token = await SharedLocalStore.getAccessToken();

  var response = await http.delete(
    Uri.parse('$accountManagementUrl/$id'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );
  return response;
}

Future<http.Response> deleteSharedAccount(String id) async {
  String token = await SharedLocalStore.getAccessToken();

  var response = await http.post(
    Uri.parse('$accountManagementUrl/$id/unshare'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );

  return response;
}

Future<ServerResponse<String>> unshareUserAccount(
    String accountId, String username) async {
  String token = await SharedLocalStore.getAccessToken();

  var responseDeleteAcc = await http.post(
    Uri.parse('$accountManagementUrl/$accountId/unshare/$username'),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );

  ServerResponse<String> serverResponse;

  if (responseDeleteAcc.statusCode == 200) {
    var data = jsonDecode(responseDeleteAcc.body);

    if (data['success']) {
      data = data['data'];
      serverResponse =
          ServerResponse(data: "Success", message: '', success: true);
    } else {
      serverResponse =
          ServerResponse(data: null, message: data['message'], success: true);
    }
  } else {
    serverResponse = ServerResponse(
        data: null, message: 'Ha ocurrido un error.', success: false);
  }

  return serverResponse;
}

Future<ServerResponse<Account?>> getCuentaByQr(String codigoQr) async {
  String token = await SharedLocalStore.getAccessToken();

  UbicacionService ubicacionService = UbicacionService();

  final Map<String, dynamic> body = {
    "codigo": codigoQr,
  };

  var headers = {
    "Content-Type": "application/json",
    "Authorization": "bearer $token"
  };

  var response = await http.post(
    Uri.parse(getAccountQrUrl),
    headers: headers,
    body: json.encode(body),
  );

  ServerResponse<Account?> serverResponse;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    if (data['success']) {
      data = data['data'];

      List<dynamic> dataActividades = data['codigosActividad'];
      List<Actividad> actividades = [];

      List<dynamic> dataUsuariosCompartidos = data['usuariosCompartidos'];
      List<UsuarioCompartido> usuariosCompartidos = [];

      List<Actividad> activityList = await Actividad.cargarActividades();

      for (var e = 0; e < dataActividades.length; e++) {
        Actividad activity = activityList.firstWhere(
          (actividad) => actividad.codigoActividad == dataActividades[e],
          orElse: () => Actividad.nullActivity,
        );

        actividades.add(activity);
      }

      for (var e = 0; e < dataUsuariosCompartidos.length; e++) {
        usuariosCompartidos.add(UsuarioCompartido(
          nombreCompleto: dataUsuariosCompartidos[e]['nombreCompleto'],
          username: dataUsuariosCompartidos[e]['username'],
        ));
      }

      Account acc = Account(
          id: data['id'].toString(),
          cedulaTipo: data['cedulaTipo'],
          cedulaNumero: data['cedulaNumero'],
          idExtranjero: data['idExtranjero'],
          nombre: data['nombre'],
          nombreComercial: data['nombreComercial'],
          telCodigoPais: data['telCodigoPais'],
          telNumero: data['telNumero'],
          faxCodigoPais: data['faxCodigoPais'],
          faxNumero: data['faxNumero'],
          correo: data['correo'],
          ubicacionCodigo: data['ubicacionCodigo'],
          ubicacionSenas: data['ubicacionSenas'],
          ubicacionSenasExtranjero: data['ubicacionSenasExtranjero'],
          tipo: data['tipo'],
          actividades: actividades,
          esCompartida: data['esCompartida'],
          usuariosCompartidos: usuariosCompartidos);

      Ubicacion? ubicacion =
          await ubicacionService.getUbicacion(acc.ubicacionCodigo);

      acc.nombreProvincia = ubicacion!.provincia.nombre;
      acc.nombreCanton = ubicacion.canton.nombre;
      acc.nombreDistrito = ubicacion.distrito.nombre;
      acc.nombreBarrio = ubicacion.barrio.nombre;

      serverResponse = ServerResponse(data: acc, message: '', success: true);
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

Future<ServerResponse<Account?>> postAddSharedAccountByQr(
    String codigoQr) async {
  String token = await SharedLocalStore.getAccessToken();

  UbicacionService ubicacionService = UbicacionService();

  final Map<String, dynamic> body = {
    "codigo": codigoQr,
  };

  var headers = {
    "Content-Type": "application/json",
    "Authorization": "bearer $token"
  };

  var response = await http.post(Uri.parse(postAddSharedAccountByQrUrl),
      headers: headers, body: json.encode(body));

  ServerResponse<Account?> serverResponse;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    if (data['success']) {
      data = data['data'];

      List<dynamic> dataActividades = data['codigosActividad'];
      List<Actividad> actividades = [];

      List<dynamic> dataUsuariosCompartidos = data['usuariosCompartidos'];
      List<UsuarioCompartido> usuariosCompartidos = [];

      List<Actividad> activityList = await Actividad.cargarActividades();

      for (var e = 0; e < dataActividades.length; e++) {
        Actividad activity = activityList.firstWhere(
          (actividad) => actividad.codigoActividad == dataActividades[e],
          orElse: () => Actividad.nullActivity,
        );

        actividades.add(activity);
      }

      for (var e = 0; e < dataUsuariosCompartidos.length; e++) {
        usuariosCompartidos.add(UsuarioCompartido(
          nombreCompleto: dataUsuariosCompartidos[e]['nombreCompleto'],
          username: dataUsuariosCompartidos[e]['username'],
        ));
      }

      Account acc = Account(
          id: data['id'].toString(),
          cedulaTipo: data['cedulaTipo'],
          cedulaNumero: data['cedulaNumero'],
          idExtranjero: data['idExtranjero'],
          nombre: data['nombre'],
          nombreComercial: data['nombreComercial'],
          telCodigoPais: data['telCodigoPais'],
          telNumero: data['telNumero'],
          faxCodigoPais: data['faxCodigoPais'],
          faxNumero: data['faxNumero'],
          correo: data['correo'],
          ubicacionCodigo: data['ubicacionCodigo'],
          ubicacionSenas: data['ubicacionSenas'],
          ubicacionSenasExtranjero: data['ubicacionSenasExtranjero'],
          tipo: data['tipo'],
          actividades: actividades,
          esCompartida: data['esCompartida'],
          usuariosCompartidos: usuariosCompartidos);

      Ubicacion? ubicacion =
          await ubicacionService.getUbicacion(acc.ubicacionCodigo);

      acc.nombreProvincia = ubicacion!.provincia.nombre;
      acc.nombreCanton = ubicacion.canton.nombre;
      acc.nombreDistrito = ubicacion.distrito.nombre;
      acc.nombreBarrio = ubicacion.barrio.nombre;

      serverResponse = ServerResponse(data: acc, message: '', success: true);
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

Future<String> getAccountBillingQr(int id) async {
  String token = await SharedLocalStore.getAccessToken();

  var url = "$accountManagementUrl/$id/billing/qr";

  var headers = {"Authorization": "bearer $token"};
  var response = await http.get(Uri.parse(url), headers: headers);

  var data = jsonDecode(response.body);
  data = data['data'];

  return data;
}

Future<String> getAccountShareQr(int id) async {
  String token = await SharedLocalStore.getAccessToken();

  var url = "$accountManagementUrl/$id/share/qr";
  var headers = {"Authorization": "bearer $token"};
  var response = await http.get(Uri.parse(url), headers: headers);

  var data = jsonDecode(response.body);
  data = data['data'];

  return data;
}

Future<http.Response> _getAccounts() async {
  String token = await SharedLocalStore.getAccessToken();

  var headers = {"Authorization": "bearer $token"};
  var response = await http.get(Uri.parse(getAccountsUrl), headers: headers);

  return response;
}

Future<List<Account>> mapAccountListResponse(var response) async {
  var data = jsonDecode(response.body);
  data = data['data'];
  List<Account> accounts = [];

  for (var i = 0; i < data.length; i++) {
    List<dynamic> dataActividades = data[i]['codigosActividad'];
    List<dynamic> dataUsuariosCompartidos = data[i]['usuariosCompartidos'];
    List<Actividad> actividades = [];
    List<UsuarioCompartido> usuariosCompartidos = [];
    List<Actividad> activityList = await Actividad.cargarActividades();

    for (var e = 0; e < dataActividades.length; e++) {
      Actividad activity = activityList.firstWhere(
        (actividad) => actividad.codigoActividad == dataActividades[e],
        orElse: () => Actividad.nullActivity,
      );

      actividades.add(activity);
    }

    for (var e = 0; e < dataUsuariosCompartidos.length; e++) {
      usuariosCompartidos.add(UsuarioCompartido(
        nombreCompleto: dataUsuariosCompartidos[e]['nombreCompleto'],
        username: dataUsuariosCompartidos[e]['username'],
      ));
    }

    UbicacionService ubicacionService = UbicacionService();

    Ubicacion? ubicacion =
        await ubicacionService.getUbicacion(data[i]['ubicacionCodigo']);

    accounts.add(Account(
        id: data[i]['id'].toString(),
        cedulaTipo: data[i]['cedulaTipo'],
        cedulaNumero: data[i]['cedulaNumero'],
        idExtranjero: data[i]['idExtranjero'],
        nombre: data[i]['nombre'],
        nombreComercial: data[i]['nombreComercial'],
        telCodigoPais: data[i]['telCodigoPais'],
        telNumero: data[i]['telNumero'],
        faxCodigoPais: data[i]['faxCodigoPais'],
        faxNumero: data[i]['faxNumero'],
        correo: data[i]['correo'],
        ubicacionCodigo: data[i]['ubicacionCodigo'],
        ubicacionSenas: data[i]['ubicacionSenas'],
        ubicacionSenasExtranjero: data[i]['ubicacionSenasExtranjero'],
        tipo: data[i]['tipo'],
        actividades: actividades,
        nombreProvincia: ubicacion!.provincia.nombre,
        nombreCanton: ubicacion.canton.nombre,
        nombreDistrito: ubicacion.distrito.nombre,
        nombreBarrio: ubicacion.barrio.nombre,
        esCompartida: data[i]['esCompartida'],
        usuariosCompartidos: usuariosCompartidos));
  }
  return accounts;
}

Future<List<Account>> getAccountList() async {
  var response = await _getAccounts();
  if (response.statusCode == 200) {
    return mapAccountListResponse(response);
  }
  return [];
}
