import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/account.dart';

const host = '192.168.18.90';

Future<http.Response> _getCuentaByQr(String codigoQr) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');

  final Map<String, dynamic> data = {
    "codigo": codigoQr,
  };

  var url = "http://$host/api/Cuenta/cuentabyqr";

  var headers = {
    "Content-Type": "application/json",
    "Authorization": "bearer $token"
  };

  var response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(data));

  return response;
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
        tipo: data[i]['tipo']));
  }
  return accounts;
}

Future<Account> getCuentaTemporal(String username, String id) async {
  var response = await _getCuentaTemporal(username, id);
  var data = jsonDecode(response.body);
  data = data['data'];
  Account account = Account(
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
      tipo: data['tipo']);

  return account;
}

Future<http.Response> getCuentaByQr(String codigoQr) async {
  var response = await _getCuentaByQr(codigoQr);

  return response;
}
