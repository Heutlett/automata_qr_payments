import 'package:flutter/material.dart';

class AccountManagementScreen extends StatefulWidget {
  const AccountManagementScreen({Key? key}) : super(key: key);

  @override
  State<AccountManagementScreen> createState() =>
      _AccountManagementScreenState();
}

class _AccountManagementScreenState extends State<AccountManagementScreen> {
  List<AccountWidget> _accounts = [];

  @override
  Widget build(BuildContext context) {
    final dynamic accounts =
        ModalRoute.of(context)?.settings.arguments as dynamic;

    _initAccounts(accounts);

    return Scaffold(
      appBar: AppBar(
        title: Text('Administración de cuentas'),
      ),
      body: Column(
        children: [
          SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                onPressed: () {
                  _createAccount();
                },
                child: Text('Crear cuenta'),
              ),
              ElevatedButton(
                onPressed: () {
                  _editAccount();
                },
                child: Text('Editar cuenta'),
              ),
              ElevatedButton(
                onPressed: () {
                  _deleteAccount();
                },
                child: Text('Borrar cuenta'),
              ),
            ],
          ),
          SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              children: _accounts,
            ),
          ),
        ],
      ),
    );
  }

  void _createAccount() {
    Navigator.of(context).pushNamed("/create_account");
  }

  void _initAccounts(dynamic accounts) {
    setState(() {
      _accounts.clear();

      for (var i = 0; i < accounts.length; i++) {
        _accounts.add(AccountWidget(
            cedulaTipo: accounts[i]['cedulaTipo'],
            cedulaNum: accounts[i]['cedulaNumero'],
            nombre: accounts[i]['nombre']));
      }
    });
  }

  void _editAccount() {
    // Aquí implementa la lógica para editar una cuenta existente
  }

  void _deleteAccount() {
    // Aquí implementa la lógica para borrar una cuenta existente
  }
}

class AccountWidget extends StatelessWidget {
  final String cedulaTipo;
  final String cedulaNum;
  final String nombre;

  const AccountWidget({
    Key? key,
    required this.cedulaTipo,
    required this.cedulaNum,
    required this.nombre,
  }) : super(key: key);

// _questionIndex < _questions.length
//             ? Quiz(
//                 questions: _questions,
//                 answerQuestion: _answerQuestion,
//                 questionIndex: _questionIndex,
//               )
//             : Result(_totalScore, _resetQuiz),

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      color: cedulaTipo == 'Juridica'
          ? Color.fromARGB(255, 163, 152, 245)
          : Color.fromARGB(255, 152, 207, 245),
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              cedulaTipo,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Text(
              cedulaNum,
              style: TextStyle(fontSize: 13),
            ),
            SizedBox(height: 16),
            Text(
              nombre,
              style: TextStyle(fontSize: 13),
            ),
          ],
        ),
      ),
    );
  }
}
