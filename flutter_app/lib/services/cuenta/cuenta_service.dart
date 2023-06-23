import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/account.dart';

import 'package:flutter_app/models/actividad.dart';
import 'package:flutter_app/models/server_response.dart';
import 'package:flutter_app/models/ubicacion.dart';

import 'package:flutter_app/utils/config.dart';

const String selectedHost = "host_adrian";

Future<http.Response> postCreateAccount(Object? cuenta) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var responseCreateAcc = await http.post(
    Uri.parse('http://$host/api/Cuenta'),
    body: jsonEncode(cuenta),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );
  return responseCreateAcc;
}

Future<http.Response> putEditAccount(String id, Object? cuenta) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var responseCreateAcc = await http.put(
    Uri.parse('http://$host/api/Cuenta'),
    body: jsonEncode(cuenta),
    headers: {
      'Content-Type': 'application/json',
      'Authorization': 'bearer $token'
    },
  );
  return responseCreateAcc;
}

Future<ServerResponse<String>> deleteOwnAccount(String id) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var responseDeleteAcc = await http.delete(
    Uri.parse('http://$host/api/Cuenta/$id'),
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
        data: null,
        message: 'Ha ocurrido un error, probablemente el token ha expirado',
        success: false);
  }

  return serverResponse;
}

Future<ServerResponse<String>> deleteSharedAccount(String id) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var responseDeleteAcc = await http.post(
    Uri.parse('http://$host/api/Cuenta/$id/unshare'),
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
        data: null,
        message: 'Ha ocurrido un error, probablemente el token ha expirado',
        success: false);
  }

  return serverResponse;
}

Future<ServerResponse<Account?>> _getCuentaByQr(String codigoQr) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  final Map<String, dynamic> body = {
    "codigo": codigoQr,
  };

  var url = "http://$host/api/Cuenta/billing/cuentabyqr";

  var headers = {
    "Content-Type": "application/json",
    "Authorization": "bearer $token"
  };

  var response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(body));

  ServerResponse<Account?> serverResponse;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    if (data['success']) {
      data = data['data'];

      List<dynamic> dataActividades = data['actividades'];
      List<Actividad> actividades = [];

      List<dynamic> dataUsuariosCompartidos = data['usuariosCompartidos'];
      List<String> usuariosCompartidos = [];

      for (var e = 0; e < dataActividades.length; e++) {
        actividades.add(Actividad(
            codigoActividad: dataActividades[e]['codigo'].toString(),
            nombre: dataActividades[e]['nombre']));
      }

      for (var e = 0; e < dataUsuariosCompartidos.length; e++) {
        usuariosCompartidos.add(dataUsuariosCompartidos[e]);
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

      ServerResponse<Ubicacion> ubicacion =
          await getUbicacion(acc.ubicacionCodigo);

      if (ubicacion.success) {
        acc.nombreProvincia = ubicacion.data!.provincia.nombre;
        acc.nombreCanton = ubicacion.data!.canton.nombre;
        acc.nombreDistrito = ubicacion.data!.distrito.nombre;
        acc.nombreBarrio = ubicacion.data!.barrio.nombre;
      }

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

Future<ServerResponse<Account?>> shareAccountByQr(String codigoQr) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  final Map<String, dynamic> body = {
    "codigo": codigoQr,
  };

  var url = "http://$host/api/Cuenta/share";

  var headers = {
    "Content-Type": "application/json",
    "Authorization": "bearer $token"
  };

  var response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(body));

  ServerResponse<Account?> serverResponse;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);

    if (data['success']) {
      data = data['data'];

      List<dynamic> dataActividades = data['actividades'];
      List<Actividad> actividades = [];

      List<dynamic> dataUsuariosCompartidos = data['usuariosCompartidos'];
      List<String> usuariosCompartidos = [];

      for (var e = 0; e < dataActividades.length; e++) {
        actividades.add(Actividad(
            codigoActividad: dataActividades[e]['codigo'].toString(),
            nombre: dataActividades[e]['nombre']));
      }

      for (var e = 0; e < dataUsuariosCompartidos.length; e++) {
        usuariosCompartidos.add(dataUsuariosCompartidos[e]);
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

      ServerResponse<Ubicacion> ubicacion =
          await getUbicacion(acc.ubicacionCodigo);

      if (ubicacion.success) {
        acc.nombreProvincia = ubicacion.data!.provincia.nombre;
        acc.nombreCanton = ubicacion.data!.canton.nombre;
        acc.nombreDistrito = ubicacion.data!.distrito.nombre;
        acc.nombreBarrio = ubicacion.data!.barrio.nombre;
      }

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
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var url = "http://$host/api/Cuenta/$id/billing/qr";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  var data = jsonDecode(response.body);
  data = data['data'];

  return data;
}

Future<String> getAccountShareQr(int id) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var url = "http://$host/api/Cuenta/$id/share/qr";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  var data = jsonDecode(response.body);
  data = data['data'];

  return data;
}

Future<Actividad?> getActividadByCode(int code) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var url = "http://$host/api/Cuenta/getActividadByCodigo/$code";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  var data = jsonDecode(response.body);

  if (data['success']) {
    data = data['data'];

    var actividad = Actividad(
        codigoActividad: data['codigo'].toString(), nombre: data['nombre']);

    return actividad;
  }
  return null;
}

Future<http.Response> _getCuentas() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');
  String host = await Config.load(selectedHost);

  var url = "http://$host/api/Cuenta/GetAll";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  return response;
}

Future<List<Account>> getCuentasList() async {
  var response = await _getCuentas();
  var data = jsonDecode(response.body);
  data = data['data'];
  List<Account> accounts = [];

  for (var i = 0; i < data.length; i++) {
    List<dynamic> dataActividades = data[i]['actividades'];
    List<dynamic> dataUsuariosCompartidos = data[i]['usuariosCompartidos'];
    List<Actividad> actividades = [];
    List<String> usuariosCompartidos = [];

    for (var e = 0; e < dataActividades.length; e++) {
      actividades.add(Actividad(
          codigoActividad: dataActividades[e]['codigo'].toString(),
          nombre: dataActividades[e]['nombre']));
    }

    for (var e = 0; e < dataUsuariosCompartidos.length; e++) {
      usuariosCompartidos.add(dataUsuariosCompartidos[e]);
    }

    ServerResponse<Ubicacion> ubicacion =
        await getUbicacion(data[i]['ubicacionCodigo']);

    if (ubicacion.success) {
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
          nombreProvincia: ubicacion.data!.provincia.nombre,
          nombreCanton: ubicacion.data!.canton.nombre,
          nombreDistrito: ubicacion.data!.distrito.nombre,
          nombreBarrio: ubicacion.data!.barrio.nombre,
          esCompartida: data[i]['esCompartida'],
          usuariosCompartidos: usuariosCompartidos));
    } else {
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
          esCompartida: data[i]['esCompartida'],
          usuariosCompartidos: usuariosCompartidos));
    }
  }
  return accounts;
}

Future<ServerResponse<Account?>> getCuentaByQr(String codigoQr) async {
  var response = await _getCuentaByQr(codigoQr);

  return response;
}

Future<ServerResponse<Ubicacion>> getUbicacion(String codigo) async {
  String host = await Config.load(selectedHost);
  var url = "http://$host/api/Cuenta/Ubicacion/$codigo";

  var response = await http.get(Uri.parse(url));
  ServerResponse<Ubicacion> serverResponse;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data['success']) {
      data = data['data'];
      serverResponse = ServerResponse(
        data: Ubicacion(
            provincia: Provincia(
                id: data['provincia'],
                nombre: data['nombreProvincia'].toUpperCase()),
            canton: Canton(
                id: data['canton'], nombre: data['nombreCanton'].toUpperCase()),
            distrito: Distrito(
                id: data['distrito'],
                nombre: data['nombreDistrito'].toUpperCase()),
            barrio: Barrio(
                id: data['barrio'],
                nombre: data['nombreBarrio'].toUpperCase())),
        message: '',
        success: true,
      );
    } else {
      serverResponse = ServerResponse(
        data: null,
        message: data['message'],
        success: false,
      );
    }
  } else {
    serverResponse = ServerResponse(
      data: null,
      message: 'Ha ocurrido un error al obtener la informacion de la ubicacion',
      success: false,
    );
  }

  return serverResponse;
}

Future<ServerResponse<List<Map<String, dynamic>>>> getProvincias() async {
  ServerResponse<List<Map<String, dynamic>>> serverResponse;
  String host = await Config.load(selectedHost);

  var url = "http://$host/api/Cuenta/UbicacionProvincias";

  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var responseDecoded = jsonDecode(response.body);

    if (responseDecoded['success']) {
      var data = responseDecoded['data'];
      List<Map<String, dynamic>> provincias = data.cast<Map<String, dynamic>>();
      serverResponse = ServerResponse(
        data: provincias,
        message: responseDecoded['message'],
        success: true,
      );
    } else {
      serverResponse = ServerResponse(
        data: null,
        message: responseDecoded['message'],
        success: false,
      );
    }
  } else {
    serverResponse = ServerResponse(
      data: null,
      message: 'Ha ocurrido un error al obtener la informacion de la ubicacion',
      success: false,
    );
  }

  return serverResponse;
}

Future<ServerResponse<List<Map<String, dynamic>>>> getCantones(
    int provincia) async {
  ServerResponse<List<Map<String, dynamic>>> serverResponse;
  String host = await Config.load(selectedHost);
  var url = "http://$host/api/Cuenta/UbicacionCantones?provincia=$provincia";

  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var responseDecoded = jsonDecode(response.body);

    if (responseDecoded['success']) {
      var data = responseDecoded['data'];
      List<Map<String, dynamic>> cantones = data.cast<Map<String, dynamic>>();
      serverResponse = ServerResponse(
        data: cantones,
        message: responseDecoded['message'],
        success: true,
      );
    } else {
      serverResponse = ServerResponse(
        data: null,
        message: responseDecoded['message'],
        success: false,
      );
    }
  } else {
    serverResponse = ServerResponse(
      data: null,
      message: 'Ha ocurrido un error al obtener la informacion de la ubicacion',
      success: false,
    );
  }

  return serverResponse;
}

Future<ServerResponse<List<Map<String, dynamic>>>> getDistritos(
    int provincia, int canton) async {
  ServerResponse<List<Map<String, dynamic>>> serverResponse;
  String host = await Config.load(selectedHost);

  var url =
      "http://$host/api/Cuenta/UbicacionDistritos?provincia=$provincia&canton=$canton";

  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var responseDecoded = jsonDecode(response.body);

    if (responseDecoded['success']) {
      var data = responseDecoded['data'];
      List<Map<String, dynamic>> distritos = data.cast<Map<String, dynamic>>();
      serverResponse = ServerResponse(
        data: distritos,
        message: responseDecoded['message'],
        success: true,
      );
    } else {
      serverResponse = ServerResponse(
        data: null,
        message: responseDecoded['message'],
        success: false,
      );
    }
  } else {
    serverResponse = ServerResponse(
      data: null,
      message: 'Ha ocurrido un error al obtener la informacion de la ubicacion',
      success: false,
    );
  }

  return serverResponse;
}

Future<ServerResponse<List<Map<String, dynamic>>>> getBarrios(
    int provincia, int canton, int distrito) async {
  ServerResponse<List<Map<String, dynamic>>> serverResponse;

  String host = await Config.load(selectedHost);
  var url =
      "http://$host/api/Cuenta/UbicacionBarrios?provincia=$provincia&canton=$canton&distrito=$distrito";

  var response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    var responseDecoded = jsonDecode(response.body);

    if (responseDecoded['success']) {
      var data = responseDecoded['data'];
      List<Map<String, dynamic>> barrios = data.cast<Map<String, dynamic>>();
      serverResponse = ServerResponse(
        data: barrios,
        message: responseDecoded['message'],
        success: true,
      );
    } else {
      serverResponse = ServerResponse(
        data: null,
        message: responseDecoded['message'],
        success: false,
      );
    }
  } else {
    serverResponse = ServerResponse(
      data: null,
      message: 'Ha ocurrido un error al obtener la informacion de la ubicacion',
      success: false,
    );
  }

  return serverResponse;
}
