//import 'package:flutter/material.dart';

// home.dart
const String homeWelcomeTitle = '¡Bienvenido a QR Payments!';
const String homeRegisterButtonTitle = 'Registrarse';
const String homeLoginButtonTitle = 'Iniciar sesión';

// register.dart
final RegExp emailRegExp = RegExp(
  r'^\s*(([^<>()\[\]\.,;:\s@"]+(\.[^<>()\[\]\.,;:\s@"]+)*)|(".+"))@(([^<>()\[\]\.,;:\s@"]+\.)+[^<>()\[\]\.,;:\s@"]{0,})\s*$',
);
const String registerTitle = 'Registro de usuario';

// login.dart
const String loginTitle = 'Inicio de sesión';

Map<int, String> days = {
  1: 'Lunes',
  2: 'Martes',
  3: 'Miércoles',
  4: 'Jueves',
  5: 'Viernes',
  6: 'Sábado',
  7: 'Domingo',
};

Map<int, String> months = {
  1: 'Enero',
  2: 'Febrero',
  3: 'Marzo',
  4: 'Abril',
  5: 'Mayo',
  6: 'Junio',
  7: 'Julio',
  8: 'Agosto',
  9: 'Septiembre',
  10: 'Octubre',
  11: 'Noviembre',
  12: 'Diciembre',
};
