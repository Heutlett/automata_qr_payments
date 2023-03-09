import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../models/account.dart';

class QRScreen extends StatefulWidget {
  @override
  _QRScreenState createState() => _QRScreenState();
}

class _QRScreenState extends State<QRScreen> {
  final TextEditingController _textController = TextEditingController();

  String _qrData = "";

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
        title: Text("Código QR generado"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Cuenta seleccionada:',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Container(
              width: double.infinity,
              child: Card(
                elevation: 5,
                color: args[0] == 'Juridica'
                    ? Color.fromARGB(255, 163, 152, 245)
                    : Color.fromARGB(255, 152, 207, 245),
                margin: EdgeInsets.all(8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        args[0],
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 16),
                      Text(
                        args[1],
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 16),
                      Text(
                        args[2],
                        style: TextStyle(fontSize: 13),
                      ),
                      SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 36),
            Center(
              child: Text(
                'Código QR generado',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            if (args[3].isNotEmpty) ...[
              SizedBox(height: 26),
              Center(
                child: QrImage(
                  data: args[3],
                  version: QrVersions.auto,
                  size: 200,
                ),
              ),
            ],
            SizedBox(height: 16),
            Center(
                child: Text(
              'Tiempo de expiración: 1 minuto',
              style: TextStyle(fontSize: 18),
            )),
            SizedBox(height: 76),
            Center(
                child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                      Navigator.of(context).pop();
                    },
                    child: Text('Volver al inicio')))
          ],
        ),
      ),
    );
  }
}
