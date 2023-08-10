import 'package:flutter/material.dart';
import 'dart:convert';

import '../../models/factura.dart';

class FacturaScreen extends StatelessWidget {
  FacturaScreen();

  @override
  Widget build(BuildContext context) {
    final Factura factura =
        ModalRoute.of(context)?.settings.arguments as Factura;

    String facturaJson = jsonEncode(factura);
    return Scaffold(
      appBar: AppBar(
        title: Text('Factura'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            facturaJson,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }
}
