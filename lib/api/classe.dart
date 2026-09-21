class Classe {
  final int index;
  final String name;
  final String url;

  Classe({
    required this.index,
    required this.name,
    required this.url,
  });

  factory Classe.fromJson(Map<String, dynamic> json) {
    return Classe(
      index: json['index'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}