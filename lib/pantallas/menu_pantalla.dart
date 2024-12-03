import 'package:flutter/material.dart';
import 'consulta_pais_pantalla.dart';

class MenuPantalla extends StatelessWidget {
  const MenuPantalla({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Consulta de Países', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.blue[800],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Colors.blue[200]!, Colors.blue[800]!],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMenuButton(
                context, 
                'Buscar por Nombre', 
                Icons.language, 
                TipoBusqueda.nombre
              ),
              SizedBox(height: 20),
              _buildMenuButton(
                context, 
                'Buscar por Código', 
                Icons.flag, 
                TipoBusqueda.codigo
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMenuButton(BuildContext context, String texto, IconData icono, TipoBusqueda tipo) {
    return ElevatedButton.icon(
      icon: Icon(icono, size: 30),
      label: Text(texto, style: TextStyle(fontSize: 18)),
      style: ElevatedButton.styleFrom(
        foregroundColor: Colors.white, 
        backgroundColor: Colors.blue[700],
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        elevation: 5,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ConsultaPaisPantalla(tipoBusqueda: tipo),
          ),
        );
      },
    );
  }
}