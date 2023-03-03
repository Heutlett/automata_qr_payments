import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/home_logged.dart';
import 'package:flutter_app/screens/user/register.dart';
import 'package:flutter_app/screens/user/login.dart';
import 'package:flutter_app/screens/account_management.dart';
import 'package:flutter_app/screens/user/create_account.dart';
import 'package:flutter_app/screens/facturacion/facturar.dart';
import 'package:flutter_app/screens/facturacion/factura_receptor/generate_qr.dart';
import 'package:flutter_app/screens/facturacion/factura_emisor/select_account_emisor.dart';
import 'package:flutter_app/screens/facturacion/factura_emisor/scan_qr_receptor.dart';
import 'package:flutter_app/screens/facturacion/factura_emisor/select_accounts_management.dart';
import 'package:flutter_app/screens/facturacion/create_factura.dart';
import 'package:flutter_app/screens/facturacion/factura_receptor/select_account_qr.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => HomePage(),
        "/home_logged": (BuildContext context) => HomeLoggedPage(),
        "/register": (BuildContext context) => RegistrationPage(),
        "/login": (BuildContext context) => LoginPage(),
        "/account_management": (BuildContext context) =>
            AccountManagementScreen(),
        "/create_account": (BuildContext context) => AgregarCuentaForm(),
        "/facturar": (BuildContext context) => FacturarPage(),
        "/generate_qr": (BuildContext context) => QRScreen(),
        "/select_account_emisor": (BuildContext context) =>
            SelectAccountEmisorScreen(),
        "/select_account_receptor": (BuildContext context) =>
            SelectAccountReceptorScreen(),
        "/select_account_management": (BuildContext context) =>
            SelectAccountManagementScreen(),
        "/create_factura": (BuildContext context) => CreateFactura(),
        "/select_account_qr": (BuildContext context) => SelectAccountQrPage(),
      },
    );
  }
}
