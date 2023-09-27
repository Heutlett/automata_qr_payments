import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/managers/provider_manager.dart';
import 'package:flutter_app/services/account/account_service.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/widgets/account/account_info_activities.dart';
import 'package:flutter_app/widgets/account/account_info_card_buttons.dart';
import 'package:flutter_app/widgets/account/account_info_expand.dart';
import 'package:flutter_app/widgets/account/account_info_header.dart';
import 'package:flutter_app/widgets/account/account_info_card_shared_acc.dart';
import 'package:flutter_app/models/ubicacion.dart';
import 'package:flutter_app/utils/utils.dart';
import 'package:flutter_app/widgets/general/my_text.dart';
import 'package:provider/provider.dart';

class AccountInfoCard extends StatefulWidget {
  final Account account;
  final int addButtons;
  final bool showIsShared;

  const AccountInfoCard({
    super.key,
    required this.account,
    this.addButtons = 0,
    required this.showIsShared,
  });

  @override
  State<AccountInfoCard> createState() => _AccountInfoCardState();
}

class _AccountInfoCardState extends State<AccountInfoCard> {
  bool isExpanded = false;

  late Account account;
  late int addButtons;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    account = widget.account;
    addButtons = widget.addButtons;
  }

  @override
  Widget build(BuildContext context) {
    final providerManager = Provider.of<ProviderManager>(context);
    return isLoading
        ? const Center(child: CircularProgressIndicator()) // Indicador de carga
        : Column(
            children: [
              AccountInfoCardHeader(
                cedulaTipo: account.cedulaTipo,
                cedulaNumero: account.cedulaNumero,
                nombre: account.nombre,
                alias: account.alias,
              ),
              isExpanded == true
                  ? AccountInfoCardExpand(account: account)
                  : const SizedBox(),
              AccountInfoCardActivities(activities: widget.account.actividades),
              widget.showIsShared
                  ? account.esCompartida
                      ? Card(
                          color: Colors.amber[300],
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: MyText(
                                    text: "Compartida conmigo (no soy dueño)"),
                              ),
                            ],
                          ))
                      : Card(
                          color: Colors.green[300],
                          child: const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Padding(
                                padding: EdgeInsets.all(2.0),
                                child: MyText(text: "Dueño"),
                              ),
                            ],
                          ))
                  : const SizedBox(),
              addButtons == 2
                  ? AccountInfoCardSharedAcc(account: account)
                  : const SizedBox(),
              addButtons != 0
                  ? AccountInfoCardButtons(
                      expandInfo: _expandInfo,
                      editAcc: () {
                        _showEditAccountScreen(context, providerManager);
                      },
                      deleteAcc: account.esCompartida
                          ? () {
                              _deleteSharedAcc(
                                  context, account.id, providerManager);
                            }
                          : () {
                              _deleteOwnAcc(
                                  context, account.id, providerManager);
                            },
                      shareAcc: () {
                        _shareAcc(context);
                      },
                      buttons: addButtons,
                      account: account,
                    )
                  : const SizedBox(),
            ],
          );
  }

  void _expandInfo() {
    setState(() {
      if (isExpanded) {
        isExpanded = false;
      } else {
        isExpanded = true;
      }
    });
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

  Future<String> _setUbicacionToProviderManager(
      ProviderManager providerManager) async {
    try {
      UbicacionService ubicacionService = UbicacionService();

      List<Provincia> provincias = [];

      List<Provincia> fetchedProvincias =
          await ubicacionService.getProvincias();
      setState(() {
        provincias = fetchedProvincias;
      });

      Ubicacion? ubicacion;
      Provincia selectedProvincia;
      Canton selectedCanton;
      Distrito selectedDistrito;

      ubicacion = await ubicacionService.getUbicacion(account.ubicacionCodigo);

      if (ubicacion != null) {
        selectedProvincia = provincias
            .firstWhere((provincia) => provincia.id == ubicacion!.provincia.id);
      } else {
        throw Exception('La ubicación de la cuenta es nula');
      }

      var cantonesList =
          await ubicacionService.getCantonesByProvincia(selectedProvincia.id);

      providerManager.setCantonesSelectedEditAccount(cantonesList.map((data) {
        return Canton(
          id: data.id,
          nombre: data.nombre.toUpperCase(),
        );
      }).toList());

      selectedCanton = providerManager.cantonesSelectedEditAccount!
          .firstWhere((canton) => canton.id == ubicacion!.canton.id);

      var distritosList = await ubicacionService.getDistritosByCanton(
          selectedProvincia.id, selectedCanton.id);

      providerManager.setDistritosSelectedEditAccount(distritosList.map((data) {
        return Distrito(
          id: data.id,
          nombre: data.nombre.toUpperCase(),
        );
      }).toList());

      selectedDistrito = providerManager.distritosSelectedEditAccount!
          .firstWhere((distrito) => distrito.id == ubicacion!.distrito.id);

      var barriosList = await ubicacionService.getBarriosByDistrito(
          selectedProvincia.id, selectedCanton.id, selectedDistrito.id);

      providerManager.setBarriosSelectedEditAccount(barriosList.map((data) {
        return Barrio(
          id: data.id,
          nombre: data.nombre.toUpperCase(),
        );
      }).toList());

      return '';
    } catch (e) {
      return e.toString();
    }
  }

  void _showEditAccountScreen(
      BuildContext context, ProviderManager providerManager) async {
    _setLoadingTrue();
    String result = await _setUbicacionToProviderManager(providerManager);
    _setLoadingFalse();

    if (result != '') {
      if (context.mounted) {
        showAlertDialog(
          context,
          'Error',
          'Ha ocurrido un error al obtener la ubicación de la cuenta: $result',
          'Aceptar',
        );
      }
    }

    _setLoadingTrue();
    providerManager.setSelectedEditAccount(account);
    _setLoadingFalse();

    if (context.mounted) {
      Navigator.of(context).pushNamed(editAccountRouteName);
    }
  }

  void _shareAcc(BuildContext context) async {
    _setLoadingTrue();
    var codigoQR = await getAccountShareQr(int.parse(account.id));
    _setLoadingTrue();

    if (context.mounted) {
      Navigator.of(context).pushNamed(
        shareAccountRouteName,
        arguments: [account, codigoQR],
      );
    }
  }

  void _deleteOwnAcc(BuildContext context, String accountId,
      ProviderManager providerManager) async {
    showAlertDialog2Options(
        context,
        'Aviso',
        '¿Está seguro de que desea eliminar esta cuenta?',
        'Si, acepto',
        'No, cancelar', () {
      _deleteOwnAccConfirm(context, accountId, providerManager);
    });
  }

  void _deleteOwnAccConfirm(BuildContext context, String accountId,
      ProviderManager providerManager) async {
    _setLoadingTrue();
    var response = await deleteOwnAccount(accountId);
    _setLoadingFalse();

    if (response.statusCode == 200) {
      _setLoadingTrue();
      List<Account> accounts = await mapAccountListResponse(response);
      _setLoadingFalse();

      if (context.mounted) {
        providerManager.reloadAccountsInAccountManagement(context, accounts);
      }
    } else {
      if (context.mounted) {
        showAlertDialog(context, 'Error',
            'Ha ocurrido un error al intentar eliminar la cuenta', 'Aceptar');
      }
    }
  }

  void _deleteSharedAcc(BuildContext context, String accountId,
      ProviderManager providerManager) async {
    showAlertDialog2Options(
        context,
        'Aviso',
        '¿Está seguro de que desea eliminar esta cuenta?',
        'Si, acepto',
        'No, cancelar', () {
      _deleteSharedAccConfirm(context, accountId, providerManager);
    });
  }

  void _deleteSharedAccConfirm(BuildContext context, String accountId,
      ProviderManager providerManager) async {
    _setLoadingTrue();
    var response = await deleteSharedAccount(accountId);
    _setLoadingFalse();

    if (response.statusCode == 200) {
      _setLoadingTrue();
      List<Account> accounts = await mapAccountListResponse(response);
      _setLoadingFalse();

      if (context.mounted) {
        providerManager.reloadAccountsInAccountManagement(context, accounts);
      }
    } else {
      if (context.mounted) {
        showAlertDialog(context, 'Error',
            'Ha ocurrido un error al intentar eliminar la cuenta', 'Aceptar');
      }
    }
  }
}
