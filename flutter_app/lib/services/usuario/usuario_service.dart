import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_app/utils/config.dart';

const String selectedHost = "auth_api";

Future<http.Response> postLogin(String username, String password) async {
  String host = await Config.load(selectedHost);
  var url = "https://$host/api/auth/login";

  final Map<String, dynamic> data = {
    "username": username,
    "password": password
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(data));

  return response;
}

Future<http.Response> postRegister(
    String username, String name, String password, String email) async {
  String host = await Config.load(selectedHost);
  var url = "http:s//$host/api/auth/register";

  final Map<String, dynamic> data = {
    "nombreCompleto": name,
    "username": username,
    "password": password,
    "email": email
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.post(Uri.parse(url),
      headers: headers, body: json.encode(data));

  return response;
}
