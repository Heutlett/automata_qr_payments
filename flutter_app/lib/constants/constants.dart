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

// create_account.dart
final List<String> cedulaTipos = [
  'Fisica',
  'Juridica',
  'DIMEX',
  'NITE',
];
final List<String> tiposCuenta = [
  'Receptor',
  'Emisor',
];

// create_factura.dart
const int defaultMonedaId = 250;
const int defaultMedioPago = 1;
const int defaultCondicionVenta = 1;

final Map<int, String> tiposMoneda = {
  250: 'Colones',
  56: 'Dolares',
};

final Map<int, String> mediosPago = {
  1: 'Efectivo',
  2: 'Tarjeta',
  3: 'Cheque',
  4: 'Transferencia deposito',
  5: 'Recaudado terceros',
  99: 'Otros',
};

final Map<int, String> condicionesVenta = {
  1: 'Contado',
  2: 'Credito',
  3: 'Consignación',
  4: 'Apartado',
  5: 'Arrendamiento opción compra',
  6: 'Arrendamiento función financiera',
  7: 'Cobro a favor tercero',
  8: 'Servicios estado crédito',
  9: 'Pago servicio estado',
  99: 'Otros',
};

// productos_factura.dart

final Map<int, String> cabysOptions = {
  1: 'Minerales; electricidad, gas y agua',
  2: 'Productos alimenticios, bebidas y tabaco...',
  3: 'Bienes transportables, excepto productos...',
  4: 'Productos metálicos, maquinaria y equipo',
  5: 'Construcciones y servicios de construcción',
  6: 'Servicios de venta, alojamiento, transporte...',
  7: 'Servicios financieros y servicios conexos...',
  8: 'Servicios prestados a las empresas y ...',
  9: 'Servicios para la comunidad, sociales y ...'
};

final List<String> unidadesMedida = [
  'Al',
  'Alc',
  'Cm',
  'I',
  'Os',
  'Sp',
];

final Map<int, String> tiposCodigoComercial = {
  1: 'Código del producto del vendedor',
  2: 'Código del producto del comprador',
  3: 'Código del producto asignado por la industria',
  4: 'Código de uso interno',
  99: 'Otros',
};
