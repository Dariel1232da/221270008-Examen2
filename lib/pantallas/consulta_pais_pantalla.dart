import 'package:flutter/material.dart';
import '../modelos/pais_modelo.dart';
import '../servicios/pais_servicio.dart';

enum TipoBusqueda { nombre, codigo }

class ConsultaPaisPantalla extends StatefulWidget {
  final TipoBusqueda tipoBusqueda;

  const ConsultaPaisPantalla({Key? key, required this.tipoBusqueda}) : super(key: key);

  @override
  _ConsultaPaisPantallaState createState() => _ConsultaPaisPantallaState();
}

class _ConsultaPaisPantallaState extends State<ConsultaPaisPantalla> {
  final TextEditingController _controlador = TextEditingController();
  final PaisServicio _paisServicio = PaisServicio();
  List<PaisModelo> _paises = [];
  bool _cargando = false;
  String _error = '';

  void _buscarPais() async {
    setState(() {
      _cargando = true;
      _error = '';
    });

    try {
      if (widget.tipoBusqueda == TipoBusqueda.nombre) {
        _paises = await _paisServicio.buscarPaisPorNombre(_controlador.text);
      } else {
        PaisModelo pais = await _paisServicio.buscarPaisPorCodigo(_controlador.text);
        _paises = [pais];
      }
    } catch (e) {
      setState(() {
        _error = 'No se encontró el país';
        _paises = [];
      });
    }

    setState(() {
      _cargando = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.tipoBusqueda == TipoBusqueda.nombre 
              ? 'Buscar País por Nombre' 
              : 'Buscar País por Código',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
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
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                controller: _controlador,
                decoration: InputDecoration(
                  labelText: widget.tipoBusqueda == TipoBusqueda.nombre 
                      ? 'Nombre del País' 
                      : 'Código del País',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.search, color: Colors.blue[800]),
                    onPressed: _buscarPais,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: _construirContenido(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _construirContenido() {
    if (_cargando) {
      return Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
        ),
      );
    }

    if (_error.isNotEmpty) {
      return Center(
        child: Text(
          _error, 
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return _paises.isEmpty 
      ? Center(
          child: Text(
            'Busca un país por su nombre o código', 
            style: TextStyle(color: Colors.white, fontSize: 16),
          ),
        )
      : ListView.builder(
          itemCount: _paises.length,
          itemBuilder: (context, index) {
            final pais = _paises[index];
            return _tarjetaPais(pais);
          },
        );
  }

  Widget _tarjetaPais(PaisModelo pais) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Image.network(
              pais.bandera, 
              width: 80, 
              height: 50, 
              fit: BoxFit.cover,
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    pais.nombre, 
                    style: TextStyle(
                      fontSize: 20, 
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 8),
                  Text('Capital: ${pais.capital}'),
                  Text('Población: ${pais.poblacion}'),
                  Text('Región: ${pais.region}'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}