import 'package:flutter/material.dart';

import 'package:flutter_app/screens/widgets/general/my_text.dart';

class RecordsPage extends StatelessWidget {
  const RecordsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('QR Payments')),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            MyText(
                text: 'En desarrollo...',
                fontSize: 28.0,
                fontWeight: FontWeight.bold),
          ],
        ),
      ),
    );
  }
}
