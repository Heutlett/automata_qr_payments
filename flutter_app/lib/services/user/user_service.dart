import 'dart:async';
import 'dart:convert';
import 'package:flutter_app/constants/endpoints.dart';
import 'package:http/http.dart' as http;

Future<http.Response> postLogin(String username, String password) async {
  final Map<String, dynamic> data = {
    "username": username,
    "password": password
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.post(Uri.parse(postLoginUrl),
      headers: headers, body: json.encode(data));

  return response;
}

Future<http.Response> postRegister(
    String username, String name, String password, String email) async {
  final Map<String, dynamic> data = {
    "nombreCompleto": name,
    "username": username,
    "password": password,
    "email": email
  };

  var headers = {"Content-Type": "application/json"};

  var response = await http.post(Uri.parse(postRegisterUrl),
      headers: headers, body: json.encode(data));

  return response;
}
