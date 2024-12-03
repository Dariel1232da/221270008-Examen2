// lib/servicios/pais_servicio.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constantes/api_constantes.dart';
import '../modelos/pais_modelo.dart';

class PaisServicio {
  Future<List<PaisModelo>> buscarPaisPorNombre(String nombre) async {
    final response = await http.get(
      Uri.parse('${ApiConstantes.nombreEndpoint}$nombre'),
    );

    if (response.statusCode == 200) {
      List<dynamic> body = json.decode(response.body);
      return body.map((e) => PaisModelo.fromJson(e)).toList();
    } else {
      throw Exception('No se pudo encontrar el país');
    }
  }

  Future<PaisModelo> buscarPaisPorCodigo(String codigo) async {
    final response = await http.get(
      Uri.parse('${ApiConstantes.codigoEndpoint}$codigo'),
    );

    if (response.statusCode == 200) {
      return PaisModelo.fromJson(json.decode(response.body)[0]);
    } else {
      throw Exception('No se pudo encontrar el país');
    }
  }
}