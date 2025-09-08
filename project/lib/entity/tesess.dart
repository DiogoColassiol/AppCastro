import 'package:project/models/teses_model.dart';

class Tese {
  final int? id;
  final int? codigo;
  final String? legenda;
  final String? descricao;
  final int? tipo;
  final String? docs;

  Tese({
    this.id,
    this.codigo,
    this.legenda,
    this.descricao,
    this.tipo,
    this.docs,
  });

  Tese copyWith({
    int? id,
    int? codigo,
    String? legenda,
    int? tipo,
    String? descricao,
    String? docs,
  }) {
    return Tese(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      legenda: legenda ?? this.legenda,
      descricao: descricao ?? this.descricao,
      tipo: tipo ?? this.tipo,
      docs: docs ?? this.docs,
    );
  }

  factory Tese.fromDB(TesesDB db) {
    return Tese(
        id: db.codigo,
        descricao: db.descricao,
        legenda: db.legenda,
        docs: db.documentos);
  }
}
