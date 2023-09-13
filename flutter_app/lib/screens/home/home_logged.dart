import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import '../../models/comprobante_summary.dart';
import '../../models/server_response.dart';
import '../../services/cuenta/cuenta_service.dart';
import '../../services/factura/factura_service.dart';
import '../widgets/general/my_button.dart';
import '../widgets/general/my_text.dart';

class HomeLoggedScreen extends StatelessWidget {
  static const routeName = homeLoggedRouteName;

  const HomeLoggedScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Payments'),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const MyText(
                text: '¡Bienvenido a QR Payments!',
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
              const SizedBox(height: 40.0),
              MyButton(
                text: 'Administrar cuentas',
                function: () => _showAccountManagementPage(context),
                size: const Size(250, 60),
              ),
              const SizedBox(height: 20.0),
              MyButton(
                text: 'Facturar',
                function: () => _showFacturarPage(context),
                size: const Size(250, 60),
              ),
              const SizedBox(height: 20.0),
              MyButton(
                text: 'Historial de pagos',
                function: () => _showRecordsPage(context),
                size: const Size(250, 60),
              ),
              const SizedBox(height: 20.0),
              MyButton(
                text: 'Cerrar sesión',
                function: () => _showHomePage(context),
                size: const Size(250, 60),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showHomePage(BuildContext context) {
    Navigator.of(context).pushNamed(homeRouteName);
  }

  void _showFacturarPage(BuildContext context) {
    Navigator.of(context).pushNamed("/facturar");
  }

  void _showRecordsPage(BuildContext context) async {
    var loadedAccounts = await getCuentasList();

    Map<int, String> accountsIds = {};

    for (int i = 0; i < loadedAccounts.length; i++) {
      accountsIds[int.parse(loadedAccounts[i].id)] = loadedAccounts[i].nombre;
    }
    ServerResponse<List<ComprobanteSummary>> response =
        await getComprobanteSummary(accountsIds.keys.first);

    if (context.mounted) {
      Navigator.of(context)
          .pushNamed("/records", arguments: [accountsIds, response.data]);
    }
  }

  Future<void> _showAccountManagementPage(BuildContext context) async {
    if (context.mounted) {
      Navigator.of(context).pushNamed("/account_management");
    }
  }
}
