import 'package:flutter/material.dart';
import 'package:flutter_app/constants/route_names.dart';
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

  // -- Add shared account
  Account? _addedSharedAccount;
  Account? get addedSharedAccount => _addedSharedAccount;

  // -- Scan Qr Receptor
  Account? _qrReceptorAccount;
  Account? get qrReceptorAccount => _qrReceptorAccount;

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

  void clearSelectedEditAccount() {
    _selectedEditAccount = null;
    notifyListeners();
  }

  // -- Qr Receptor Account

  void setQrReceptorAccount(Account qrReceptorAccount) {
    _qrReceptorAccount = qrReceptorAccount;
    notifyListeners();
  }

  void clearQrReceptorAccount() {
    _qrReceptorAccount = null;
    notifyListeners();
  }

  // -- Ubicacion

  void setCantonesSelectedEditAccount(
      List<Canton> cantonesSelectedEditAccount) {
    _cantonesSelectedEditAccount = cantonesSelectedEditAccount;
    notifyListeners();
  }

  void clearCantonesSelectedEditAccount() {
    _cantonesSelectedEditAccount!.clear();
    notifyListeners();
  }

  void setDistritosSelectedEditAccount(
      List<Distrito> distritosSelectedEditAccount) {
    _distritosSelectedEditAccount = distritosSelectedEditAccount;
    notifyListeners();
  }

  void clearDistritosSelectedEditAccount() {
    _distritosSelectedEditAccount!.clear();
    notifyListeners();
  }

  void setBarriosSelectedEditAccount(List<Barrio> barriosSelectedEditAccount) {
    _barriosSelectedEditAccount = barriosSelectedEditAccount;
    notifyListeners();
  }

  void clearBarriosSelectedEditAccount() {
    _barriosSelectedEditAccount!.clear();
    notifyListeners();
  }

  // -- Add shared account
  void setAddedSharedAccount(Account addedSharedAccount) {
    _addedSharedAccount = addedSharedAccount;
    notifyListeners();
  }

  void reloadAccountsInAccountManagement(
      BuildContext context, List<Account> accounts) {
    setMyAccounts(accounts);

    if (context.mounted) {
      Navigator.of(context).pushNamedAndRemoveUntil(
          accountManagementRouteName, (Route<dynamic> route) => false);
    }
  }
}
