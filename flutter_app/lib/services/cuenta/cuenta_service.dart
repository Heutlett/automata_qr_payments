import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_app/models/account.dart';

Future<http.Response> _getCuentas() async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');

  var url = "http://10.0.2.2:5275/api/Cuenta/GetAll";

  var headers = {"Authorization": "bearer $token"};

  var response = await http.get(Uri.parse(url), headers: headers);

  return response;
}

Future<List<Account>> getCuentasList() async {
  var response = await _getCuentas();
  var data = jsonDecode(response.body);
  data = data['data'];
  List<Account> accounts = [];
  print(data);
  print(data[0]['id']);
  print(data[1]['id']);

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
  print(accounts);
  return accounts;
}
