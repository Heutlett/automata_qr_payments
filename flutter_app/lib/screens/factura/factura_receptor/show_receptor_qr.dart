import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/widgets/account/account_info_header.dart';
import 'package:qr_flutter/qr_flutter.dart';

import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_app/widgets/general/my_text.dart';

class ShowReceptorQrScreen extends StatefulWidget {
  static const String routeName = showReceptorQrRouteName;

  const ShowReceptorQrScreen({super.key});

  @override
  State<ShowReceptorQrScreen> createState() => _ShowReceptorQrScreenState();
}

class _ShowReceptorQrScreenState extends State<ShowReceptorQrScreen> {
  final TextEditingController _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<String> args =
        ModalRoute.of(context)?.settings.arguments as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Código QR generado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(
              text: 'Cuenta seleccionada:',
              fontSize: 25,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 20),
            Card(
                elevation: 5,
                margin: const EdgeInsets.all(8),
                color: args[0] == 'Juridica'
                    ? const Color.fromARGB(255, 180, 193, 255)
                    : const Color.fromARGB(255, 180, 234, 255),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AccountInfoCardHeader(
                    cedulaTipo: args[0],
                    cedulaNumero: args[1],
                    nombre: args[2],
                  ),
                )),
            const SizedBox(height: 20),
            const MyText(
              text: 'Código QR generado',
              fontSize: 24,
            ),
            if (args[3].isNotEmpty) ...[
              const SizedBox(height: 26),
              Center(
                child: QrImage(
                  data: args[3],
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
            ],
            const SizedBox(height: 16),
            const MyText(
              text: 'Tiempo de expiración: 1 minuto',
              fontSize: 18,
            ),
            const SizedBox(height: 76),
            MyButton(
                function: () => _showHome(context), text: 'Volver al inicio')
          ],
        ),
      ),
    );
  }

  void _showHome(BuildContext context) {
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }
}
