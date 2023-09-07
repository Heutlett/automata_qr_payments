import 'package:device_information/device_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:location/location.dart';

void showAlertDialog(
  BuildContext context,
  String title,
  String message,
  String buttonText,
) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(buttonText),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showAlertDialogWithRoute(
  BuildContext context,
  String title,
  String message,
  String buttonText,
  String route,
) {
  // set up the button
  Widget okButton = TextButton(
    child: Text(buttonText),
    onPressed: () {
      Navigator.of(context).pushNamed(route);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showAlertDialog2Options(
  BuildContext context,
  String title,
  String message,
  String buttonText1,
  String buttonText2,
  VoidCallback function,
) {
  // set up the buttons
  Widget executeButton = TextButton(
    onPressed: function,
    child: Text(buttonText1),
  );

  Widget cancelButton = TextButton(
    child: Text(buttonText2),
    onPressed: () {
      Navigator.of(context).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      executeButton,
      cancelButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

void showAlertDialogWithFunction(
  BuildContext context,
  String title,
  String message,
  String buttonText,
  VoidCallback function,
) {
  // set up the button
  Widget okButton = TextButton(
    onPressed: function,
    child: Text(buttonText),
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text(title),
    content: Text(message),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Future<String> getDeviceModel() async {
  try {
    String modelName = await DeviceInformation.deviceModel;

    return modelName;
  } on PlatformException {
    return 'Failed to get platform version.';
  }
}

Future<List<double>> getLocation() async {
  Location location = Location();
  bool serviceEnabled;
  PermissionStatus permissionGranted;

  // Verificar si el servicio de ubicación está habilitado en el dispositivo.
  serviceEnabled = await location.serviceEnabled();
  if (!serviceEnabled) {
    serviceEnabled = await location.requestService();
    if (!serviceEnabled) {
      throw Exception('El servicio de ubicación está desactivado');
    }
  }

  // Verificar si la aplicación tiene permiso para acceder a la ubicación.
  permissionGranted = await location.hasPermission();
  if (permissionGranted == PermissionStatus.denied) {
    permissionGranted = await location.requestPermission();
    if (permissionGranted != PermissionStatus.granted) {
      throw Exception('Permiso de ubicación denegado');
    }
  }

  // Obtener la ubicación actual del dispositivo.
  LocationData locationData = await location.getLocation();
  return [locationData.longitude!, locationData.latitude!];
}
