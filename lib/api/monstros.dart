class Monstros {
  final String index;
 final String name;
 final String  url;

  Monstros({
 required this.index,
 required this.name,
 required this.url,
});

factory Monstros.fromJson(Map<String,dynamic> json){
  return Monstros(
  index: json['index'] ?? '',
  name: json['name'] ?? '',
  url: json['url'] ?? '',
  );

}
}
