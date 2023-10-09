import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import 'package:flutter_app/widgets/general/my_text.dart';
import 'package:provider/provider.dart';

class HomeLoggedScreen extends StatefulWidget {
  static const routeName = homeLoggedRouteName;

  const HomeLoggedScreen({Key? key}) : super(key: key);

  @override
  State<HomeLoggedScreen> createState() => _HomeLoggedScreenState();
}

class _HomeLoggedScreenState extends State<HomeLoggedScreen> {
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);
    return Scaffold(
      body: Center(
        child: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: WillPopScope(
                onWillPop: () async {
                  // Mostrar AlertDialog cuando se intenta ir hacia atrás o salir de la aplicación
                  bool shouldExit = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('¿Estás seguro?'),
                        content: const Text(
                            'Si presionas Salir, se cerrará la sesión.'),
                        actions: <Widget>[
                          TextButton(
                            child: const Text('Cancelar'),
                            onPressed: () {
                              Navigator.of(context).pop(
                                  false); // Permanecer en la pantalla actual
                            },
                          ),
                          TextButton(
                            child: const Text('Salir'),
                            onPressed: () {
                              Navigator.of(context).pushNamedAndRemoveUntil(
                                  homeRouteName,
                                  (Route<dynamic> route) => false);
                            },
                          ),
                        ],
                      );
                    },
                  );

                  return shouldExit;
                },
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const MyText(
                      text: homeWelcomeTitle,
                      fontSize: 25.0,
                      fontWeight: FontWeight.bold,
                    ),
                    const SizedBox(height: 40.0),
                    MyButton(
                      text: 'QR datos de cliente',
                      function: () =>
                          _showSelectReceptorAccountToGenerateQrScreen(
                              context, providerManager),
                      size: const Size(250, 60),
                    ),
                    const SizedBox(height: 20.0),
                    MyButton(
                      text: 'Escanear QR',
                      function: () => _showSelectReceptorAccount(context),
                      size: const Size(250, 60),
                    ),
                    const SizedBox(height: 20.0),
                    // MyButton(
                    //   text: 'Historial de pagos',
                    //   function: () =>
                    //       _showFacturasHistoryScreen(context, providerManager),
                    //   size: const Size(250, 60),
                    // ),
                    // const SizedBox(height: 20.0),
                    MyButton(
                      text: 'Administrar cuentas',
                      function: () => _showAccountManagementScreen(
                          context, providerManager),
                      size: const Size(250, 60),
                    ),
                    const SizedBox(height: 20.0),
                    MyButton(
                      text: 'Cerrar sesión',
                      function: () => _showHomeScreen(context),
                      size: const Size(250, 60),
                    ),
                  ],
                ),
              )),
      ),
    );
  }

  void _setLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  void _setLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  Future<void> _loadAccounts(ProviderManager providerManager) async {
    var loadedAccounts = await getAccountList();
    providerManager.setMyAccounts(loadedAccounts);
  }

  Future<void> _showAccountManagementScreen(
      BuildContext context, ProviderManager providerManager) async {
    _setLoadingTrue();
    await _loadAccounts(providerManager);
    _setLoadingFalse();

    if (context.mounted) {
      Navigator.of(context).pushNamed(accountManagementRouteName);
    }
  }

  void _showHomeScreen(BuildContext context) {
    Navigator.of(context).pushNamed(homeRouteName);
  }

  // void _showFacturarScreen(BuildContext context) {
  //   Navigator.of(context).pushNamed(facturarRouteName);
  // }

  void _showSelectReceptorAccountToGenerateQrScreen(
      BuildContext context, ProviderManager providerManager) async {
    _setLoadingTrue();
    await _loadAccounts(providerManager);
    _setLoadingFalse();

    if (context.mounted) {
      Navigator.of(context).pushNamed(generateQrRouteName);
    }
  }

  void _showSelectReceptorAccount(BuildContext context) {
    Navigator.of(context).pushNamed(scanQrReceptorAccountRouteName);
  }

  // void _showFacturasHistoryScreen(
  //     BuildContext context, ProviderManager providerManager) async {
  //   _setLoadingTrue();
  //   await _loadAccounts(providerManager);
  //   _setLoadingFalse();

  //   if (context.mounted) {
  //     Navigator.of(context).pushNamed(facturasHistoryRouteName);
  //   }
  // }
}
