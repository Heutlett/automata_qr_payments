import 'package:flutter/material.dart';
import 'package:flutter_app/screens/home.dart';
import 'package:flutter_app/screens/home_logged.dart';
import 'package:flutter_app/screens/user/register.dart';
import 'package:flutter_app/screens/user/login.dart';
import 'package:flutter_app/screens/account/account_management.dart';
import 'package:flutter_app/screens/account/create_account.dart';
import 'package:flutter_app/screens/facturar.dart';
import 'package:flutter_app/screens/factura_receptor/generate_qr.dart';
import 'package:flutter_app/screens/factura_emisor/select_account_emisor.dart';
import 'package:flutter_app/screens/factura_emisor/scan_qr_receptor.dart';
import 'package:flutter_app/screens/factura_emisor/select_accounts_management.dart';
import 'package:flutter_app/screens/factura_emisor/create_factura.dart';
import 'package:flutter_app/screens/factura_receptor/select_account_qr.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => const HomePage(),
        "/home_logged": (BuildContext context) => const HomeLoggedPage(),
        "/register": (BuildContext context) => const RegistrationPage(),
        "/login": (BuildContext context) => const LoginPage(),
        "/account_management": (BuildContext context) =>
            const AccountManagementScreen(),
        "/create_account": (BuildContext context) => const AgregarCuentaForm(),
        "/facturar": (BuildContext context) => const FacturarPage(),
        "/generate_qr": (BuildContext context) => QRScreen(),
        "/select_account_emisor": (BuildContext context) =>
            const SelectAccountEmisorScreen(),
        "/select_account_receptor": (BuildContext context) =>
            const SelectAccountReceptorScreen(),
        "/select_account_management": (BuildContext context) =>
            const SelectAccountManagementScreen(),
        "/create_factura": (BuildContext context) => CreateFactura(),
        "/select_account_qr": (BuildContext context) =>
            const SelectAccountQrPage(),
      },
    );
  }
}
