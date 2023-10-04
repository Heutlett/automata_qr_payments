import 'package:flutter/material.dart';
import 'package:flutter_app/widgets/general/circle.dart';

class TypeAccountSymb extends StatelessWidget {
  const TypeAccountSymb({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 16),
          child: Text(
            'Cuentas propias:',
            style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: Row(
            children: [
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  side: const BorderSide(color: Colors.grey, width: 1.0),
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: [
                    SizedBox(width: 10),
                    CircleWidget(
                        radius: 7, color: Color.fromARGB(255, 190, 237, 255)),
                    SizedBox(width: 15),
                    Text('Física'),
                    SizedBox(width: 10),
                  ]),
                ),
              ),
              Card(
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                      10.0), // Ajusta el radio para controlar la redondez de las esquinas
                  side: const BorderSide(
                      color: Colors.grey,
                      width: 1.0), // Añade un borde negro de 1 píxel
                ),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Row(children: [
                    SizedBox(width: 10),
                    CircleWidget(
                        radius: 7, color: Color.fromARGB(255, 190, 201, 255)),
                    SizedBox(width: 15),
                    Text('Jurídica'),
                    SizedBox(width: 10),
                  ]),
                ),
              )
            ],
          ),
        ),
      ],
    );
  }
}
