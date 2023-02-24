import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class HomeLoggedPage extends StatelessWidget {
  HomeLoggedPage({Key? key}) : super(key: key);
  final _scaffKey = GlobalKey<ScaffoldState>();

  void _showAccountManagement(BuildContext context) async {
    var response = await _getCuentas();
    var data = jsonDecode(response.body);

    Navigator.of(context)
        .pushNamed("/account_management", arguments: data['data']);
  }

  Future<http.Response> _getCuentas() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');

    var url = "http://10.0.2.2:5275/api/Cuenta/GetAll";

    var headers = {"Authorization": "bearer $token"};

    var response = await http.get(Uri.parse(url), headers: headers);

    return response;
  }

  @override
  Widget build(BuildContext context) {
    final String message = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      key: _scaffKey,
      appBar: AppBar(
        title: Text('QR Payments'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '¡Bienvenido ${message}!',
              style: TextStyle(fontSize: 28.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 40.0),
            ElevatedButton(
              onPressed: () {
                _showAccountManagement(context);
              },
              child:
                  Text('Administrar cuentas', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {},
              child: Text('Facturar', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed("/");
              },
              child: Text('Cerrar sesion', style: TextStyle(fontSize: 18)),
              style: ElevatedButton.styleFrom(
                fixedSize: Size(200, 60),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
