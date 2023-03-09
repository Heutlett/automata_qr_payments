import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/account.dart';

import '../../models/actividad.dart';
import '../../models/serverResponse.dart';
import '../../models/ubicacion.dart';

const host = '192.168.18.90';

Future<ServerResponse<Account?>> _getCuentaByQr(String codigoQr) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');

  final Map<String, dynamic> body = {
    "codigo": codigoQr,
  };

  var url = "http://$host/api/Cuenta/cuentabyqr";

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

      for (var e = 0; e < dataActividades.length; e++) {
        actividades.add(Actividad(
            codigoActividad: dataActividades[e]['codigo'].toString(),
            nombre: dataActividades[e]['nombre']));
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
      );

      ServerResponse<Ubicacion> ubicacion =
          await getUbicacion(acc.ubicacionCodigo);

      if (ubicacion.success) {
        acc.nombreProvincia = ubicacion.data!.provincia;
        acc.nombreCanton = ubicacion.data!.canton;
        acc.nombreDistrito = ubicacion.data!.distrito;
        acc.nombreBarrio = ubicacion.data!.barrio;
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

Future<String> getAccountQr(int id) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');

  var url = "http://$host/api/Cuenta/qr/$id";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  var data = jsonDecode(response.body);
  data = data['data'];

  return data;
}

Future<Actividad?> getActividadByCode(int code) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');

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

  var url = "http://$host/api/Cuenta/GetAll";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  return response;
}

Future<http.Response> _getCuentaTemporal(String username, String id) async {
  var url = "http://$host/api/Cuenta/cuentaTemporal/$username/$id";

  var response = await http.get(Uri.parse(url));

  return response;
}

Future<List<Account>> getCuentasList() async {
  var response = await _getCuentas();
  var data = jsonDecode(response.body);
  data = data['data'];
  List<Account> accounts = [];

  for (var i = 0; i < data.length; i++) {
    List<dynamic> dataActividades = data[i]['actividades'];
    List<Actividad> actividades = [];

    for (var e = 0; e < dataActividades.length; e++) {
      actividades.add(Actividad(
          codigoActividad: dataActividades[e]['codigo'].toString(),
          nombre: dataActividades[e]['nombre']));
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
        nombreProvincia: ubicacion.data!.provincia,
        nombreCanton: ubicacion.data!.canton,
        nombreDistrito: ubicacion.data!.distrito,
        nombreBarrio: ubicacion.data!.barrio,
      ));
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
      ));
    }
  }
  return accounts;
}

Future<ServerResponse<Account?>> getCuentaByQr(String codigoQr) async {
  var response = await _getCuentaByQr(codigoQr);

  return response;
}

Future<ServerResponse<Ubicacion>> getUbicacion(String codigo) async {
  var url = "http://$host/api/Cuenta/Ubicacion/$codigo";

  var response = await http.get(Uri.parse(url));
  ServerResponse<Ubicacion> serverResponse;

  if (response.statusCode == 200) {
    var data = jsonDecode(response.body);
    if (data['success']) {
      data = data['data'];
      serverResponse = ServerResponse(
        data: Ubicacion(
            provincia: data['nombreProvincia'],
            canton: data['nombreCanton'],
            distrito: data['nombreDistrito'],
            barrio: data['nombreBarrio']),
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
