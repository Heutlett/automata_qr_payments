import 'package:flutter/material.dart';
import 'package:flutter_app/models/account.dart';
import 'package:flutter_app/models/ubicacion.dart';

class ProviderManager extends ChangeNotifier {
  // -- Accounts
  final List<Account> _myAccounts = [];
  List<Account> get myAccounts => _myAccounts;

  // -- Edit Account
  Account? _selectedEditAccount;
  Account? get selectedEditAccount => _selectedEditAccount;

  List<Canton>? _cantonesSelectedEditAccount;
  List<Canton>? get cantonesSelectedEditAccount => _cantonesSelectedEditAccount;

  List<Distrito>? _distritosSelectedEditAccount;
  List<Distrito>? get distritosSelectedEditAccount =>
      _distritosSelectedEditAccount;

  List<Barrio>? _barriosSelectedEditAccount;
  List<Barrio>? get barriosSelectedEditAccount => _barriosSelectedEditAccount;

  // -- Accounts
  void setMyAccounts(List<Account> accounts) {
    _myAccounts.clear();
    _myAccounts.insertAll(0, accounts);
    notifyListeners();
  }

  // -- Edit Account
  void setSelectedEditAccount(Account selectedEditAccount) {
    _selectedEditAccount = selectedEditAccount;
    notifyListeners();
  }

  void setCantonesSelectedEditAccount(
      List<Canton> cantonesSelectedEditAccount) {
    _cantonesSelectedEditAccount = cantonesSelectedEditAccount;
    notifyListeners();
  }

  void setDistritosSelectedEditAccount(
      List<Distrito> distritosSelectedEditAccount) {
    _distritosSelectedEditAccount = distritosSelectedEditAccount;
    notifyListeners();
  }

  void setBarriosSelectedEditAccount(List<Barrio> barriosSelectedEditAccount) {
    _barriosSelectedEditAccount = barriosSelectedEditAccount;
    notifyListeners();
  }

  void clearSelectedEditAccount() {
    _selectedEditAccount = null;
    notifyListeners();
  }

  void clearCantonesSelectedEditAccount() {
    _cantonesSelectedEditAccount!.clear();
    notifyListeners();
  }

  void clearDistritosSelectedEditAccount() {
    _distritosSelectedEditAccount!.clear();
    notifyListeners();
  }

  void clearBarriosSelectedEditAccount() {
    _barriosSelectedEditAccount!.clear();
    notifyListeners();
  }
}
