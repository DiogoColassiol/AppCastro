class ReceitaModel {
  final String nome;
  final String fantasia;
  final String abertura;
  final String situacao;

  ReceitaModel({
    required this.nome,
    required this.fantasia,
    required this.abertura,
    required this.situacao,
  });
  factory ReceitaModel.fromMap(Map<String, dynamic> map) {
    return ReceitaModel(
      nome: map['nome'],
      fantasia: map['fantasia'],
      abertura: map['abertura'],
      situacao: map['situacao'],
    );
  }
}
