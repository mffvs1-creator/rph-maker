class Persoapi {
  final int id;
  final String nome;
  final String classe;
  final String raca;
  final int pvAtual;
  final int pvMax;
  final int forca;
  final int agilidade;
  final int inteligencia;
  final int ca;
  final String imagem;

  Persoapi({
    required this.id,
    required this.nome,
    required this.raca,
    required this.classe,
    required this.pvAtual,
    required this.pvMax,
    required this.forca,
    required this.agilidade,
    required this.inteligencia,
    required this.ca,
    required this.imagem,
  });

  factory Persoapi.fromJson(Map<String, dynamic> json) {
    return Persoapi(
      id: json['id'] ?? 0,
      nome: json['nome'] ?? '',
      raca: json['raca'] ?? '',
      classe: json['classe'] ?? '',
      pvAtual: json['pvAtual'] ?? 0,
      pvMax: json['pvMax'] ?? 0,
      forca: json['forca'] ?? 0,
      agilidade: json['agilidade'] ?? 0,
      inteligencia: json['inteligencia'] ?? 0,
      ca: json['ca'] ?? 0,
      imagem: json['imagem'] ?? '',
    );
  }
}