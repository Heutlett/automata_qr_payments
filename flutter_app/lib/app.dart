import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/home_logged.dart';
import 'package:flutter_app/screens/demo.dart';
import 'package:flutter_app/screens/user/register.dart';
import 'package:flutter_app/screens/user/login.dart';
import 'package:flutter_app/screens/user/account_management.dart';
import 'package:flutter_app/screens/user/create_account.dart';
import 'package:flutter_app/screens/facturacion/facturar.dart';
import 'package:flutter_app/screens/facturacion/generate_qr.dart';
import 'package:flutter_app/screens/facturacion/select_account_emisor.dart';
import 'package:flutter_app/screens/facturacion/select_account_receptor.dart';
import 'package:flutter_app/screens/facturacion/create_factura.dart';

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
        "/select_account_emisor": (BuildContext context) =>
            SelectAccountEmisorScreen(),
        "/select_account_receptor": (BuildContext context) =>
            SelectAccountReceptorScreen(),
        "/create_factura": (BuildContext context) => CreateFactura(),
      },
    );
  }
}
