class ReceitaModel {
  final String? nome;
  final String? fantasia;
  final String? abertura;
  final String? situacao;

  ReceitaModel({
    this.nome,
    this.fantasia,
    this.abertura,
    this.situacao,
  });
  factory ReceitaModel.fromMap(Map<String, dynamic> map) {
    return ReceitaModel(
      nome: map['nome'],
      fantasia: map['fantasia'],
      abertura: map['abertura'],
      situacao: map['situacao'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'nome': nome,
      'fantasia': fantasia,
      'abertura': abertura,
      'situacao': situacao,
    };
  }
}
