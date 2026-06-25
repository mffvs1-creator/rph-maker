class Opcoes {
  late String Name;

  Opcoes({
    required this.Name,
  });

  Opcoes.fromJson(Map<String, dynamic> json) {
    Name = (json['NAME']).toString();
  }
}