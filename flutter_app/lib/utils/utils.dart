import 'package:flutter/material.dart';

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
