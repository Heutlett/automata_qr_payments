import 'package:flutter/material.dart';

class MyBackButton extends StatelessWidget {
  final String routeName;

  const MyBackButton({
    super.key,
    required this.routeName,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      padding: const EdgeInsets.all(4),
      decoration: ShapeDecoration(
        color: Colors.blue,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        shadows: const [
          BoxShadow(
            color: Color(0x1E000000),
            blurRadius: 8,
            offset: Offset(0, 2),
            spreadRadius: 2,
          )
        ],
      ),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).pushNamedAndRemoveUntil(
              routeName, (Route<dynamic> route) => false);
        },
        child: const Icon(
          Icons.keyboard_arrow_left,
          size: 28,
        ),
      ),
    );
  }
}
