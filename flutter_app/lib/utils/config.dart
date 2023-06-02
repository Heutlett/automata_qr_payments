import 'dart:convert';
import 'package:flutter/services.dart';

class Config {
  static Future<String> load(String selected_host) async {
    try {
      final configString = await rootBundle.loadString('assets/config.json');
      final config = jsonDecode(configString);
      return config[selected_host];
    } catch (e) {
      print('Error al cargar la configuración: $e');
      return "Error";
    }
  }
}
