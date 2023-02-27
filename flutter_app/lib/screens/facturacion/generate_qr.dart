import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: Text("Código QR generado"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 250,
              child: TextField(
                controller: _textController,
                decoration: InputDecoration(
                    hintText: "Texto para generar el código QR"),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  _qrData = _textController.text;
                });
              },
              child: Text("Generar código QR"),
            ),
            if (_qrData.isNotEmpty) ...[
              SizedBox(height: 16),
              QrImage(
                data: _qrData,
                version: QrVersions.auto,
                size: 200,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
