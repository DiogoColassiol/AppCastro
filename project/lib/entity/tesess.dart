class Tese {
  final int? id;
  final int? codigo;
  final String? legenda;
  final String? descricao;
  final String? docs;

  Tese({
    this.id,
    this.codigo,
    this.legenda,
    this.descricao,
    this.docs,
  });

  Tese copyWith({
    int? id,
    int? codigo,
    String? legenda,
    String? descricao,
    String? docs,
  }) {
    return Tese(
      id: id ?? this.id,
      codigo: codigo ?? this.codigo,
      legenda: legenda ?? this.legenda,
      descricao: descricao ?? this.descricao,
      docs: docs ?? this.docs,
    );
  }
}
