class Raca {
  String index;
  String name;
  String url;

  Raca({
  required this.index,
  required this.name,
  required this.url,
  });
  
  

  factory Raca.fromJson(Map<String, dynamic> json) {
    return Raca(
      index: json['index'] ?? 0,
      name: json['name'] ?? '',
      url: json['url'] ?? '',
    );
  }
}