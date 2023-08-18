import 'package:flutter/material.dart';
import 'package:flutter_app/screens/factura_emisor/factura_screen.dart';
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
import 'package:flutter_app/screens/account/edit_account.dart';
import 'package:flutter_app/screens/records/records.dart';
import 'package:flutter_app/screens/account/share_account.dart';
import 'package:flutter_app/screens/account/add_shared_account.dart';
import 'package:flutter_app/screens/account/added_shared_account.dart';

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
        "/edit_account": (BuildContext context) => const EditAccount(),
        "/records": (BuildContext context) => const RecordsPage(),
        "/share_account": (BuildContext context) => const ShareAccountScreen(),
        "/add_shared_account": (BuildContext context) =>
            const AddSharedAccount(),
        "/added_shared_account": (BuildContext context) =>
            const AddedSharedAccount(),
        "/show_factura_json": (BuildContext context) => const FacturaScreen()
      },
    );
  }
}
