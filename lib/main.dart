// lib/main.dart
import 'package:flutter/material.dart';
import 'pantallas/menu_pantalla.dart';

void main() {
  runApp(MiAplicacion());
}

class MiAplicacion extends StatelessWidget {
  const MiAplicacion({Key? key}) : super(key: key);  // Añade esto

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Consulta de Países',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MenuPantalla(),
    );
  }
}