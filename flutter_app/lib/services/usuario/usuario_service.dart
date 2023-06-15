import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_app/utils/config.dart';

const String selected_host = "host_adrian";

Future<http.Response> postLogin(String username, String password) async {
  String host = await Config.load(selected_host);
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
  String host = await Config.load(selected_host);
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
