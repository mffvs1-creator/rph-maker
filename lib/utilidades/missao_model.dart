class Missao {
  final String id;
  final String titulo;
  final String recompensa;
  final String dificulte;

  Missao({
    required this.id,
    required this.titulo,
    required this.recompensa,
    required this.dificulte,
  });

  factory Missao.fromJson(Map<String, dynamic> json) {
    return Missao(
      id: json['id'] ?? '',
      titulo: json['titulo'] ?? 'Missão Sem Nome',
      recompensa: json['recompensa'] ?? 'Sem Recompensa',
      dificulte: json['dificulte'] ?? 'Normal',
    );
  }
}
