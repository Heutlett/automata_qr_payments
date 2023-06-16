import 'package:flutter/material.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/screens/widgets/account/account_info_activities.dart';
import 'package:flutter_app/screens/widgets/account/account_info_card_buttons.dart';
import 'package:flutter_app/screens/widgets/account/account_info_expand.dart';
import 'package:flutter_app/screens/widgets/account/account_info_header.dart';
import 'package:flutter_app/models/ubicacion.dart';
import 'package:flutter_app/utils/utils.dart';

class AccountInfoCard extends StatefulWidget {
  final Account account;
  final int addButtons;

  const AccountInfoCard(
      {super.key, required this.account, this.addButtons = 0});

  @override
  State<AccountInfoCard> createState() => _AccountInfoCardState();
}

class _AccountInfoCardState extends State<AccountInfoCard> {
  bool isExpand = false;

  late Account account;
  late int addButtons;

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
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AccountInfoCardHeader(
          cedulaTipo: widget.account.cedulaTipo,
          cedulaNumero: widget.account.cedulaNumero,
          nombre: widget.account.nombre,
        ),
        isExpand == true
            ? AccountInfoCardExpand(account: account)
            : const SizedBox(),
        AccountInfoCardActivities(activities: widget.account.actividades),
        addButtons != 0
            ? AccountInfoCardButtons(
                expandInfo: expandInfo,
                editAcc: () {
                  editAcc(context);
                },
                deleteAcc: () {
                  deleteAcc(context, account.id);
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
    var response = await getUbicacion(account.ubicacionCodigo);

    try {
      if (response.success) {
        ubicacion = response.data;
        if (ubicacion != null) {
          selectedProvincia = provincias.firstWhere(
              (provincia) => provincia.id == ubicacion!.provincia.id);
        } else {
          throw Exception('Ubicación nula');
        }
      } else {
        throw Exception('Respuesta de error del API');
      }

      if (selectedProvincia != null) {
        var cantonesResponse = await getCantones(selectedProvincia!.id);
        if (cantonesResponse.success) {
          var cantonesList = cantonesResponse.data;
          if (cantonesList != null) {
            _cantones = cantonesList.map((data) {
              return Canton(
                id: data['canton'],
                nombre: data['nombreCanton'].toUpperCase(),
              );
            }).toList();
          } else {
            throw Exception('Lista de cantones nula');
          }
        } else {
          throw Exception('Respuesta de error del API');
        }
      } else {
        throw Exception('Provincia seleccionada nula');
      }

      selectedCanton =
          _cantones!.firstWhere((canton) => canton.id == ubicacion!.canton.id);

      if (selectedCanton != null) {
        var distritosResponse =
            await getDistritos(selectedProvincia!.id, selectedCanton!.id);
        if (distritosResponse.success) {
          var distritosList = distritosResponse.data;
          if (distritosList != null) {
            _distritos = distritosList.map((data) {
              return Distrito(
                id: data['distrito'],
                nombre: data['nombreDistrito'].toUpperCase(),
              );
            }).toList();
          } else {
            throw Exception('Lista de distritos nula');
          }
        } else {
          throw Exception('Respuesta de error del API');
        }
      } else {
        throw Exception('Cantón seleccionado nulo');
      }

      selectedDistrito = _distritos!
          .firstWhere((distrito) => distrito.id == ubicacion!.distrito.id);

      if (selectedDistrito != null) {
        var barriosResponse = await getBarrios(
            selectedProvincia!.id, selectedCanton!.id, selectedDistrito!.id);
        if (barriosResponse.success) {
          var barriosList = barriosResponse.data;
          if (barriosList != null) {
            _barrios = barriosList.map((data) {
              return Barrio(
                id: data['barrio'],
                nombre: data['nombreBarrio'].toUpperCase(),
              );
            }).toList();
          } else {
            throw Exception('Lista de barrios nula');
          }
        } else {
          throw Exception('Respuesta de error del API');
        }
      } else {
        throw Exception('Distrito seleccionado nulo');
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
    if (context.mounted) {
      Navigator.of(context).pushNamed("/share_account", arguments: account);
    }
  }

  void deleteAcc(BuildContext context, String accountId) async {
    showAlertDialog2Options(
        context,
        'Aviso',
        '¿Está seguro de que desea eliminar esta cuenta?',
        'Si, acepto',
        'No, cancelar', () {
      deleteAccConfirm(context, accountId);
    });
  }
}

void deleteAccConfirm(BuildContext context, String accountId) async {
  var deleteResponse = await deleteAccount(accountId);
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
