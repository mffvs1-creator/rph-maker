class personagem {
  final int? id;
  final String nome;
  final int forca;
  final int agilidade;
  final int inteligencia;
  final String classe;
  final int pvAtual;
  final int pvMax;
  final int ca;
  final String imagem;

  personagem ({
    this.id,
    required this.nome,
    required this.forca,
    required this.agilidade,
    required this.inteligencia,
    required this.classe,
    required this.pvAtual,
    required this.pvMax,
    required this.ca,
    required this.imagem,
  });

  factory personagem.fromJson(Map<String, dynamic> json) {
    return personagem(
      id: json['id'] as int?,
      nome: json['nome'] as String,
      classe: json['classe'] as String,
      pvAtual: json['pvAtual'] as int,
      pvMax: json['pvMax'] as int,
      forca: json['forca'] as int,
      agilidade: json['agilidade'] as int,
      inteligencia: json['inteligencia'] as int,
      ca: json['ca'] as int,
      imagem: json['imagem'] as String,
    );
  }
}
Map<String, dynamic> personagemToMap(personagem p) {
  return {
    'id': p.id,
    'nome': p.nome,
    'forca': p.forca,
    'agilidade': p.agilidade,
    'inteligencia': p.inteligencia,
    'classe': p.classe,
    'pvAtual': p.pvAtual,
    'pvMax': p.pvMax,
    'ca': p.ca,
    'imagem': p.imagem,
  };
} 
