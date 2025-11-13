import 'package:project/models/teses_model.dart';

class Tese {
  final int? id;
  final String? legenda;
  final String? descricao;

  final String? docs;

  Tese({
    this.id,
    this.legenda,
    this.descricao,
    this.docs,
  });

  Tese copyWith({
    int? id,
    String? legenda,
    int? tipo,
    String? descricao,
    String? docs,
  }) {
    return Tese(
      id: id ?? this.id,
      legenda: legenda ?? this.legenda,
      descricao: descricao ?? this.descricao,
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

  factory Tese.fromMap(Map<String, dynamic> map) {
    return Tese(
      id: map['id'] ?? 0,
      legenda: map['legenda'] ?? '',
      descricao: map['descricao'] ?? '',
      docs: map['documentos'] ?? '',
    );
  }
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'legenda': legenda,
      'descricao': descricao,
      'docs': docs,
    };
  }
}
