import 'package:flutter/material.dart';

class MyButton extends StatelessWidget {
  final String text;
  final Function function;
  final double fontSize;
  final Size size;
  final Color backgroundColor;
  final Color foregroundColor;

  const MyButton({
    super.key,
    required this.text,
    required this.function,
    this.fontSize = 18,
    this.size = const Size(200, 60),
    this.backgroundColor = Colors.blue,
    this.foregroundColor = Colors.white,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () => function(context),
      style: ElevatedButton.styleFrom(
        fixedSize: size,
        backgroundColor: backgroundColor,
      ),
      child: Text(text,
          style: TextStyle(fontSize: fontSize, color: foregroundColor)),
    );
  }
}
