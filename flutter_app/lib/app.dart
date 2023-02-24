import 'package:flutter/material.dart';
import 'package:flutter_app/screens/my_home_page.dart';
import 'package:flutter_app/screens/demo.dart';
import 'package:flutter_app/screens/register.dart';
import 'package:flutter_app/screens/login.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      initialRoute: "/",
      routes: {
        "/": (BuildContext context) => HomePage(),
        "/demo": (BuildContext context) => DemoPage(),
        "/register": (BuildContext context) => RegistrationPage(),
        "/login": (BuildContext context) => LoginPage(),
      },
    );
  }
}
