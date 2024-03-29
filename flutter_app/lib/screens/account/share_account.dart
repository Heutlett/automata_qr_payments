import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/widgets/account/account_info_header.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/account.dart';
import '../../widgets/general/my_button.dart';
import '../../widgets/general/my_text.dart';

class ShareAccountScreen extends StatefulWidget {
  static const String routeName = shareAccountRouteName;

  const ShareAccountScreen({super.key});

  @override
  State<ShareAccountScreen> createState() => _ShareAccountScreenState();
}

class _ShareAccountScreenState extends State<ShareAccountScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<dynamic> args =
        ModalRoute.of(context)?.settings.arguments as List<dynamic>;

    final Account acc = args[0];
    final String codigoQR = args[1];

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR generado para compartir"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(
              text: 'Cuenta compartida:',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            Card(
                elevation: 5,
                margin: const EdgeInsets.all(8),
                color: acc.cedulaTipo == 'Juridica'
                    ? const Color.fromARGB(255, 180, 193, 255)
                    : const Color.fromARGB(255, 180, 234, 255),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccountInfoCardHeader(
                    cedulaTipo: acc.cedulaTipo,
                    cedulaNumero: acc.cedulaNumero,
                    nombre: acc.nombre,
                  ),
                )),
            const SizedBox(height: 20),
            const MyText(
              text: 'Código QR generado',
              fontSize: 24,
            ),
            const SizedBox(height: 26),
            Center(
              child: QrImage(
                data: codigoQR,
                version: QrVersions.auto,
                size: 200,
              ),
            ),
            const SizedBox(height: 16),
            const MyText(
              text: 'Tiempo de expiración: 1 minuto',
              fontSize: 18,
            ),
            const SizedBox(height: 76),
            MyButton(
                function: () => _showHome(context), text: 'Volver a cuentas')
          ],
        ),
      ),
    );
  }

  void _showHome(BuildContext context) {
    Navigator.of(context).pushNamedAndRemoveUntil(
        homeLoggedRouteName, (Route<dynamic> route) => false);
    Navigator.of(context).pushNamed(accountManagementRouteName);
  }
}
