import 'package:project/models/segmentos_model.dart';

class Segmento {
  final int? id;
  final String? nome;
  final String? numTeses;

  Segmento({
    this.id,
    this.nome,
    this.numTeses,
  });

  Segmento copyWith({
    int? id,
    String? nome,
    String? numTeses,
  }) {
    return Segmento(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      numTeses: numTeses ?? this.numTeses,
    );
  }

  factory Segmento.fromDB(SegmentoDB db) {
    return Segmento(
      id: db.codigo,
      nome: db.nome,
      numTeses: db.numTeses,
    );
  }
}
