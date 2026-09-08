import 'package:rpgmaker/api/apifake/personagem.dart';
import 'package:dio/dio.dart';

class racepi {
  final dio = Dio();
  String baseUrl = 'https://www.dnd5eapi.co/api/2014/classes';

  findByCep(String nome) async {
    late Personagem personagem;
    final response = await dio.get('$baseUrl/ws/$nome/json/');

    if (response.statusCode == 200) {
      personagem = Personagem.fromJson(response.data);
    }

    return personagem;
  }
}