import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';

class ProviderManager extends ChangeNotifier {
  final List<Account> _myAccounts = [];

  List<Account> get myAccounts => _myAccounts;

  void setMyAccounts(List<Account> accounts) {
    _myAccounts.clear();
    _myAccounts.insertAll(0, accounts);
    notifyListeners();
  }
}
