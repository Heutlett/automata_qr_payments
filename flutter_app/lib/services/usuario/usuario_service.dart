import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/actividad.dart';

const host = '192.168.18.90';

Future<http.Response> postLogin(String username, String password) async {
  var url = "http://$host/Auth/Login";

  final Map<String, dynamic> data = {
    "username": username,
    "password": password
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(data));

  //print(response.body);

  return response;
}

Future<http.Response> postRegister(
    String username, String password, String email) async {
  var url = "http://$host/Auth/Register";

  final Map<String, dynamic> data = {
    "username": username,
    "password": password,
    "email": email
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(data));

  return response;
}

Future<http.Response> postCreateAccount(
    Object? cuenta, List<Actividad> actividades) async {
  final prefs = await SharedPreferences.getInstance();
  String? token = prefs.getString('accessToken');

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
