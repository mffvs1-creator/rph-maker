class Classe {
  final String index;
  final String name;
  final String url;

  Classe({
    required this.index,
    required this.name,
    required this.url,
  });

  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      index: (json['index'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      url: (json['url'] ?? '').toString(),
    );
  }
}