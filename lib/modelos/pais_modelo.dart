// lib/modelos/pais_modelo.dart
class PaisModelo {
  final String nombre;
  final String codigoPais;
  final String capital;
  final String bandera;
  final int poblacion;
  final String region;

  PaisModelo({
    required this.nombre,
    required this.codigoPais,
    required this.capital,
    required this.bandera,
    required this.poblacion,
    required this.region,
  });

  factory PaisModelo.fromJson(Map<String, dynamic> json) {
    return PaisModelo(
      nombre: json['name']['common'],
      codigoPais: json['cca3'],
      capital: json['capital'] != null ? json['capital'][0] : 'N/A',
      bandera: json['flags']['png'],
      poblacion: json['population'],
      region: json['region'],
    );
  }
}