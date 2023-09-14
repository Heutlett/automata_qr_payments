import 'package:flutter/material.dart';
import 'package:flutter_app/constants/constants.dart';
import 'package:flutter_app/constants/route_names.dart';
import 'package:flutter_app/widgets/general/my_button.dart';
import '../../widgets/general/my_text.dart';

class HomeScreen extends StatelessWidget {
  static const routeName = homeRouteName;

  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const MyText(
              text: homeWelcomeTitle,
              fontSize: 25.0,
              fontWeight: FontWeight.bold,
            ),
            const SizedBox(height: 40.0),
            MyButton(
              text: homeRegisterButtonTitle,
              function: () => _showRegisterScreen(context),
              fontSize: 18,
              size: const Size(200, 60),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
            const SizedBox(height: 20.0),
            MyButton(
              text: homeLoginButtonTitle,
              function: () => _showLoginScreen(context),
              fontSize: 18,
              size: const Size(200, 60),
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }

  void _showRegisterScreen(BuildContext context) {
    Navigator.of(context).pushNamed(registerRouteName);
  }

  void _showLoginScreen(BuildContext context) {
    Navigator.of(context).pushNamed(loginRouteName);
  }
}
