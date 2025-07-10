import 'package:project/entity/segmentos.dart';

class Segmentos {
  Segmento segmento;
  Segmentos({required this.segmento});

  factory Segmentos.fromMap(Map<String, dynamic> map) {
    return Segmentos(
      segmento: Segmento(
        id: map['codigo'],
        nome: map['nome'],
      ),
    );
  }
}
