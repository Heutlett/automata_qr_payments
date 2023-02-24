import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class DemoPage extends StatefulWidget {
  DemoPage({super.key});

  @override
  State<DemoPage> createState() => _DemoPage();
}

class _DemoPage extends State<DemoPage> {
  String _scanBarcode = '';
  String _apiResponse = '';
  final _scaffKey = GlobalKey<ScaffoldState>();

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          '#ff6666', 'Cancelar', true, ScanMode.QR);
      debugPrint(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
    });
  }

  void pruebaAPI() async {
    var response = await getProvincias();
    var data = jsonDecode(response.body);
    print(response.body);
    print(data['data'][0]['provincia']); // Accesando campos

    if (response.statusCode == 200) {
      print(response.body);

      setState(() {
        _apiResponse = response.body;
      });
    } else {
      print('Error al solicitar el API');
    }
  }

  Future<http.Response> getProvincias() async {
    var url = "http://10.0.2.2:5275/api/Cuenta/UbicacionProvincias";
    return http.get(Uri.parse(url));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        key: _scaffKey,
        appBar: AppBar(
          title: const Text('Facturacion QR Demo'),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Center(
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(50),
                color: Colors.blue[100],
                width: 300,
                height: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: () => scanQR(),
                          child: const Text('Escanear QR')),
                      SizedBox(
                        height: 50,
                      ),
                      Text('Resultado del QR :\n',
                          style: const TextStyle(fontSize: 20)),
                      Text('$_scanBarcode\n',
                          style: const TextStyle(
                              fontSize: 20,
                              color: Color.fromARGB(255, 18, 8, 154)))
                    ]),
              ),
              Container(
                color: Colors.green[100],
                width: 300,
                height: 300,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ElevatedButton(
                          onPressed: pruebaAPI,
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all<Color>(Colors.green),
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.white),
                          ),
                          child: const Text('Consultar API')),
                      SizedBox(
                        height: 50,
                      ),
                      Text('Resultado del request :\n',
                          style: const TextStyle(fontSize: 20)),
                      Text('$_apiResponse\n',
                          style: const TextStyle(
                              fontSize: 10,
                              color: Color.fromARGB(255, 17, 100, 4)))
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
