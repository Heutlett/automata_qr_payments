import 'package:flutter/material.dart';
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
  bool isExpand = false;

  late Account account;
  late int addButtons;

  UbicacionService ubicacionService = UbicacionService();

  List<Provincia> provincias = [];
  List<Canton>? _cantones;
  List<Distrito>? _distritos;
  List<Barrio>? _barrios;

  Ubicacion? ubicacion;
  Provincia? selectedProvincia;
  Canton? selectedCanton;
  Distrito? selectedDistrito;
  Barrio? selectedBarrio;

  final String errorUbicacionMessage =
      'Ha ocurrido un error al obtener la ubicación de la cuenta.';

  @override
  void initState() {
    super.initState();
    account = widget.account;
    addButtons = widget.addButtons;
    loadPronvincias();
  }

  void loadPronvincias() async {
    List<Provincia> fetchedProvincias = await ubicacionService.getProvincias();
    setState(() {
      provincias = fetchedProvincias;
    });
  }

  @override
  Widget build(BuildContext context) {
    return provincias.isEmpty
        ? const CircularProgressIndicator() // Indicador de carga
        : Column(
            children: [
              AccountInfoCardHeader(
                cedulaTipo: account.cedulaTipo,
                cedulaNumero: account.cedulaNumero,
                nombre: account.nombre,
              ),
              isExpand == true
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
                      expandInfo: expandInfo,
                      editAcc: () {
                        editAcc(context);
                      },
                      deleteAcc: account.esCompartida
                          ? () {
                              deleteSharedAcc(context, account.id);
                            }
                          : () {
                              deleteOwnAcc(context, account.id);
                            },
                      shareAcc: () {
                        shareAcc(context);
                      },
                      buttons: addButtons,
                      account: account,
                    )
                  : const SizedBox(),
            ],
          );
  }

  void expandInfo() {
    setState(() {
      if (isExpand) {
        isExpand = false;
      } else {
        isExpand = true;
      }
    });
  }

  void editAcc(BuildContext context) async {
    var response = await ubicacionService.getUbicacion(account.ubicacionCodigo);

    try {
      ubicacion = response;
      if (ubicacion != null) {
        selectedProvincia = provincias
            .firstWhere((provincia) => provincia.id == ubicacion!.provincia.id);
      } else {
        throw Exception('Ubicación nula');
      }

      if (selectedProvincia != null) {
        var cantonesList = await ubicacionService
            .getCantonesByProvincia(selectedProvincia!.id);

        _cantones = cantonesList.map((data) {
          return Canton(
            id: data.id,
            nombre: data.nombre.toUpperCase(),
          );
        }).toList();
      }

      selectedCanton =
          _cantones!.firstWhere((canton) => canton.id == ubicacion!.canton.id);

      if (selectedCanton != null) {
        var distritosList = await ubicacionService.getDistritosByCanton(
            selectedProvincia!.id, selectedCanton!.id);

        _distritos = distritosList.map((data) {
          return Distrito(
            id: data.id,
            nombre: data.nombre.toUpperCase(),
          );
        }).toList();
      }

      selectedDistrito = _distritos!
          .firstWhere((distrito) => distrito.id == ubicacion!.distrito.id);

      if (selectedDistrito != null) {
        var barriosList = await ubicacionService.getBarriosByDistrito(
            selectedProvincia!.id, selectedCanton!.id, selectedDistrito!.id);

        _barrios = barriosList.map((data) {
          return Barrio(
            id: data.id,
            nombre: data.nombre.toUpperCase(),
          );
        }).toList();
      }
    } catch (e) {
      if (context.mounted) {
        String exError = e.toString();
        showAlertDialog(
            context, 'Error', "$errorUbicacionMessage: $exError", 'Aceptar');
      }
    }

    if (context.mounted) {
      Navigator.of(context).pushNamed("/edit_account",
          arguments: [account, _cantones, _distritos, _barrios]);
    }
  }

  void shareAcc(BuildContext context) async {
    var codigoQR = await getAccountShareQr(int.parse(account.id));

    if (context.mounted) {
      Navigator.of(context)
          .pushNamed("/share_account", arguments: [account, codigoQR]);
    }
  }

  void deleteOwnAcc(BuildContext context, String accountId) async {
    showAlertDialog2Options(
        context,
        'Aviso',
        '¿Está seguro de que desea eliminar esta cuenta?',
        'Si, acepto',
        'No, cancelar', () {
      deleteOwnAccConfirm(context, accountId);
    });
  }

  void deleteOwnAccConfirm(BuildContext context, String accountId) async {
    var deleteResponse = await deleteOwnAccount(accountId);
    if (context.mounted) {
      if (deleteResponse.success) {
        showAlertDialog(context, 'Cuenta eliminada',
            'La cuenta ha sido eliminada correctamente.', 'Aceptar');
      } else {
        showAlertDialog(context, 'Error', deleteResponse.message, 'Aceptar');
      }
    }
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/home_logged", (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed('/account_management');
    }
  }

  void deleteSharedAcc(BuildContext context, String accountId) async {
    showAlertDialog2Options(
        context,
        'Aviso',
        '¿Está seguro de que desea eliminar esta cuenta?',
        'Si, acepto',
        'No, cancelar', () {
      deleteSharedAccConfirm(context, accountId);
    });
  }

  void deleteSharedAccConfirm(BuildContext context, String accountId) async {
    var deleteResponse = await deleteSharedAccount(accountId);
    if (context.mounted) {
      if (deleteResponse.success) {
        showAlertDialog(context, 'Cuenta eliminada',
            'La cuenta ha sido eliminada correctamente.', 'Aceptar');
      } else {
        showAlertDialog(context, 'Error', deleteResponse.message, 'Aceptar');
      }
    }
    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          "/home_logged", (Route<dynamic> route) => false);
      Navigator.of(context).pushNamed('/account_management');
    }
  }
}
