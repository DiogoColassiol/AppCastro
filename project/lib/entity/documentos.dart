class Documento {
  final int? id;
  final String? nome;

  Documento({
    this.id,
    this.nome,
  });

  Documento copyWith({
    int? id,
    String? nome,
    bool? selecionado,
  }) {
    return Documento(
      id: id ?? this.id,
      nome: nome ?? this.nome,
    );
  }
}
