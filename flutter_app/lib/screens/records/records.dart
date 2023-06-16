import 'package:flutter/material.dart';
import 'package:flutter_app/services/cuenta/cuenta_service.dart';

class RecordsPage extends StatefulWidget {
  @override
  _RecordsPageState createState() => _RecordsPageState();
}

class _RecordsPageState extends State<RecordsPage> {
  // Lista de provincias
  List<Provincia> provinces = [
    Provincia(id: 1, nombre: 'SAN JOSE'),
    Provincia(id: 2, nombre: 'ALAJUELA'),
    Provincia(id: 3, nombre: 'CARTAGO'),
    Provincia(id: 4, nombre: 'HEREDIA'),
    Provincia(id: 5, nombre: 'GUANACASTE'),
    Provincia(id: 6, nombre: 'PUNTARENAS'),
    Provincia(id: 7, nombre: 'LIMON'),
  ];

  // Lista de cantones
  List<Canton> cantones = [];

  // Lista de distritos
  List<Distrito> distritos = [];

  // Lista de barrios
  List<Barrio> barrios = [];

  Provincia? selectedProvincia;
  Canton? selectedCanton;
  Distrito? selectedDistrito;
  Barrio? selectedBarrio;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Form'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DropdownButtonFormField<Provincia>(
              value: selectedProvincia,
              items: provinces.map((province) {
                return DropdownMenuItem<Provincia>(
                  value: province,
                  child: Text(province.nombre),
                );
              }).toList(),
              onChanged: (province) {
                setState(() {
                  selectedProvincia = province;
                  selectedCanton = null;
                  selectedDistrito = null;
                  selectedBarrio = null;
                  cantones = []; // Reinicia la lista de cantones
                  distritos = []; // Reinicia la lista de distritos
                  barrios = []; // Reinicia la lista de barrios
                  // Simula la carga de los cantones para la provincia seleccionada
                  loadCantones();
                });
              },
              decoration: InputDecoration(
                labelText: 'Provincia',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<Canton>(
              value: selectedCanton,
              items: cantones.map((canton) {
                return DropdownMenuItem<Canton>(
                  value: canton,
                  child: Text(canton.nombre),
                );
              }).toList(),
              onChanged: (canton) {
                setState(() {
                  selectedCanton = canton;
                  selectedDistrito = null;
                  selectedBarrio = null;
                  distritos = []; // Reinicia la lista de distritos
                  barrios = []; // Reinicia la lista de barrios
                  // Simula la carga de los distritos para el cantón seleccionado
                  loadDistritos();
                });
              },
              decoration: InputDecoration(
                labelText: 'Cantón',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<Distrito>(
              value: selectedDistrito,
              items: distritos.map((district) {
                return DropdownMenuItem<Distrito>(
                  value: district,
                  child: Text(district.nombre),
                );
              }).toList(),
              onChanged: (district) {
                setState(() {
                  selectedDistrito = district;
                  selectedBarrio = null;
                  barrios = []; // Reinicia la lista de barrios
                  // Simula la carga de los barrios para el distrito seleccionado
                  loadBarrios();
                });
              },
              decoration: InputDecoration(
                labelText: 'Distrito',
              ),
            ),
            SizedBox(height: 16.0),
            DropdownButtonFormField<Barrio>(
              value: selectedBarrio,
              items: barrios.map((neighborhood) {
                return DropdownMenuItem<Barrio>(
                  value: neighborhood,
                  child: Text(neighborhood.nombre),
                );
              }).toList(),
              onChanged: (neighborhood) {
                setState(() {
                  selectedBarrio = neighborhood;
                });
              },
              decoration: InputDecoration(
                labelText: 'Barrio',
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Simula la carga de los cantones para la provincia seleccionada
  void loadCantones() async {
    if (selectedProvincia != null) {
      var cantonesResponse = await getCantones(selectedProvincia!.id);
      if (cantonesResponse.success) {
        var cantonesList = cantonesResponse.data;
        if (cantonesList != null) {
          setState(() {
            cantones = cantonesList.map((data) {
              return Canton(
                id: data['canton'],
                nombre: data['nombreCanton'],
              );
            }).toList();
          });
        }
      } else {}
    }
  }

  // Simula la carga de los distritos para el cantón seleccionado
  void loadDistritos() async {
    if (selectedCanton != null) {
      var distritosResponse =
          await getDistritos(selectedProvincia!.id, selectedCanton!.id);
      if (distritosResponse.success) {
        var distritosList = distritosResponse.data;
        if (distritosList != null) {
          setState(() {
            distritos = distritosList.map((data) {
              return Distrito(
                id: data['distrito'],
                nombre: data['nombreDistrito'],
              );
            }).toList();
          });
        }
      } else {}
    }
  }

  // Simula la carga de los barrios para el distrito seleccionado
  void loadBarrios() async {
    if (selectedDistrito != null) {
      var barriosResponse = await getBarrios(
          selectedProvincia!.id, selectedCanton!.id, selectedDistrito!.id);
      if (barriosResponse.success) {
        var barriosList = barriosResponse.data;
        if (barriosList != null) {
          setState(() {
            barrios = barriosList.map((data) {
              return Barrio(
                id: data['barrio'],
                nombre: data['nombreBarrio'],
              );
            }).toList();
          });
        }
      } else {}
    }
  }
}

class Provincia {
  final int id;
  final String nombre;

  Provincia({required this.id, required this.nombre});
}

class Canton {
  final int id;
  final String nombre;

  Canton({required this.id, required this.nombre});
}

class Distrito {
  final int id;
  final String nombre;

  Distrito({required this.id, required this.nombre});
}

class Barrio {
  final int id;
  final String nombre;

  Barrio({required this.id, required this.nombre});
}
