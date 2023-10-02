import 'package:flutter/material.dart';
import 'package:flutter_app/managers/provider_manager.dart';
//import 'package:flutter_app/screens/factura/factura_emisor/show_factura.dart';
import 'package:flutter_app/screens/home/home.dart';
import 'package:flutter_app/screens/home/home_logged.dart';
import 'package:flutter_app/screens/user/register.dart';
import 'package:flutter_app/screens/user/login.dart';
import 'package:flutter_app/screens/account_management/account_management.dart';
import 'package:flutter_app/screens/account_management/create_account.dart';
import 'package:flutter_app/screens/factura/facturar.dart';
import 'package:flutter_app/screens/factura/factura_emisor/select_emisor_account.dart';
//import 'package:flutter_app/screens/factura/factura_emisor/scan_qr_receptor_account_fase2.dart';
import 'package:flutter_app/screens/factura/factura_emisor/scan_qr_receptor_account.dart';
import 'package:flutter_app/screens/factura/factura_emisor/show_selected_accounts.dart';
//import 'package:flutter_app/screens/factura/factura_emisor/create_factura.dart';
import 'package:flutter_app/screens/factura/factura_receptor/generate_qr.dart';
import 'package:flutter_app/screens/account_management/edit_account.dart';
//import 'package:flutter_app/screens/history/facturas_history.dart';
import 'package:flutter_app/screens/account_management/share_account.dart';
import 'package:flutter_app/screens/account_management/add_shared_account.dart';
import 'package:flutter_app/screens/account_management/show_shared_account_added.dart';
import 'package:provider/provider.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ProviderManager(),
      child: MaterialApp(
        initialRoute: HomeScreen.routeName,
        routes: {
          HomeScreen.routeName: (BuildContext context) => const HomeScreen(),
          HomeLoggedScreen.routeName: (BuildContext context) =>
              const HomeLoggedScreen(),
          RegisterScreen.routeName: (BuildContext context) =>
              const RegisterScreen(),
          LoginScreen.routeName: (BuildContext context) => const LoginScreen(),
          AccountManagementScreen.routeName: (BuildContext context) =>
              const AccountManagementScreen(),
          CreateAccountScreen.routeName: (BuildContext context) =>
              const CreateAccountScreen(),
          EditAccountScreen.routeName: (BuildContext context) =>
              const EditAccountScreen(),
          ShareAccountScreen.routeName: (BuildContext context) =>
              const ShareAccountScreen(),
          AddSharedAccountScreen.routeName: (BuildContext context) =>
              const AddSharedAccountScreen(),
          ShowSharedAccountAddedScreen.routeName: (BuildContext context) =>
              const ShowSharedAccountAddedScreen(),
          FacturarScreen.routeName: (BuildContext context) =>
              const FacturarScreen(),
          GenerateQrScreen.routeName: (BuildContext context) =>
              const GenerateQrScreen(),
          SelectEmisorAccountScreen.routeName: (BuildContext context) =>
              const SelectEmisorAccountScreen(),
          ScanQrReceptorAccountScreen.routeName: (BuildContext context) =>
              const ScanQrReceptorAccountScreen(),
          ShowSelectedAccountsScreen.routeName: (BuildContext context) =>
              const ShowSelectedAccountsScreen(),
          // CreateFacturaScreen.routeName: (BuildContext context) =>
          //     const CreateFacturaScreen(),
          // ShowFacturaScreen.routeName: (BuildContext context) =>
          //     const ShowFacturaScreen(),
          // FacturasHistoryScreen.routeName: (BuildContext context) =>
          //     const FacturasHistoryScreen(),
        },
      ),
    );
  }
}
