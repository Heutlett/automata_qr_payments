import 'dart:convert';
import 'package:flutter/services.dart';

class Config {
  static Future<String> load(String selectedHost) async {
    try {
      final configString = await rootBundle.loadString('assets/config.json');
      final config = jsonDecode(configString);
      return config[selectedHost];
    } catch (e) {
      return "Error";
    }
  }
}
