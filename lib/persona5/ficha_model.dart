
class FichasP {
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

  const FichasP({
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

  int get modificadorForca => (forca - 10) ~/ 2;
  int get modificadorAgilidade => (agilidade - 10) ~/ 2;
  int get modificadorInteligencia => (inteligencia - 10) ~/ 2;
  double get hpPercent => pvMax == 0 ? 0 : pvAtual / pvMax;


  factory FichasP.fromMap(Map<String, dynamic> map) {
    return FichasP(
      id: map['id'] as int?,
      nome: map['nome']?.toString() ?? '',
      forca: (map['forca'] as num?)?.toInt() ?? 10,
      agilidade: (map['agilidade'] as num?)?.toInt() ?? 10,
      inteligencia: (map['inteligencia'] as num?)?.toInt() ?? 10,
      classe: map['classe']?.toString() ?? '',
      pvAtual: (map['pvAtual'] as num?)?.toInt() ?? 0,
      pvMax: (map['pvMax'] as num?)?.toInt() ?? 0,
      ca: (map['ca'] as num?)?.toInt() ?? 10,
      imagem: map['imagem']?.toString() ?? '',
    );
  }

 
  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'nome': nome,
      'classe': classe,
      'pvAtual': pvAtual,
      'pvMax': pvMax,
      'forca': forca,
      'agilidade': agilidade,
      'inteligencia': inteligencia,
      'ca': ca,
      'imagem': imagem,
    };
  }

  FichasP copyWith({int? id}) {
    return FichasP(
      id: id ?? this.id,
      nome: nome,
      forca: forca,
      agilidade: agilidade,
      inteligencia: inteligencia,
      classe: classe,
      pvAtual: pvAtual,
      pvMax: pvMax,
      ca: ca,
      imagem: imagem,
    );
  }
}
