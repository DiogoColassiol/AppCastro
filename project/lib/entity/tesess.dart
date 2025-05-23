class Tese {
  final String? id;
  final String? legenda;
  final String? descricao;
  final String? docs;
  //add docs necessarios

  Tese({
    this.id,
    this.legenda,
    this.descricao,
    this.docs,
  });

  Tese copyWith({
    String? id,
    String? legenda,
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
}
