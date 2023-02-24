import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/home_logged.dart';
import 'package:flutter_app/screens/demo.dart';
import 'package:flutter_app/screens/register.dart';
import 'package:flutter_app/screens/login.dart';
import 'package:flutter_app/screens/account_management.dart';
import 'package:flutter_app/screens/create_account.dart';
import 'package:flutter_app/screens/facturar.dart';
import 'package:flutter_app/screens/generate_qr.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => HomePage(),
        "/home_logged": (BuildContext context) => HomeLoggedPage(),
        "/demo": (BuildContext context) => DemoPage(),
        "/register": (BuildContext context) => RegistrationPage(),
        "/login": (BuildContext context) => LoginPage(),
        "/account_management": (BuildContext context) =>
            AccountManagementScreen(),
        "/create_account": (BuildContext context) => AgregarCuentaForm(),
        "/facturar": (BuildContext context) => FacturarPage(),
        "/generateQR": (BuildContext context) => QRScreen(),
      },
    );
  }
}
