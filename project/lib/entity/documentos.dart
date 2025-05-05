class Documento {
  final String? id;
  final String? nome;
  bool? selecionado;

  Documento({
    this.id,
    this.nome,
    this.selecionado = false,
  });

  Documento copyWith({
    String? id,
    String? nome,
    bool? selecionado,
  }) {
    return Documento(
      id: id ?? this.id,
      nome: nome ?? this.nome,
      selecionado: selecionado ?? this.selecionado,
    );
  }
}
