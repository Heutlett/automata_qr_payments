import 'package:flutter/material.dart';
import './screens/home.dart';
import './screens/home_logged.dart';
import './screens/user/register.dart';
import './screens/user/login.dart';
import './screens/account/account_management.dart';
import './screens/account/create_account.dart';
import './screens/facturar.dart';
import './screens/factura_receptor/generate_qr.dart';
import './screens/factura_emisor/select_account_emisor.dart';
import './screens/factura_emisor/scan_qr_receptor.dart';
import './screens/factura_emisor/select_accounts_management.dart';
import './screens/factura_emisor/create_factura.dart';
import './screens/factura_receptor/select_account_qr.dart';

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
        "/generate_qr": (BuildContext context) => const QRScreen(),
        "/select_account_emisor": (BuildContext context) =>
            const SelectAccountEmisorScreen(),
        "/select_account_receptor": (BuildContext context) =>
            const SelectAccountReceptorScreen(),
        "/select_account_management": (BuildContext context) =>
            const SelectAccountManagementScreen(),
        "/create_factura": (BuildContext context) => const CreateFactura(),
        "/select_account_qr": (BuildContext context) =>
            const SelectAccountQrPage(),
      },
    );
  }
}
