import 'package:rpgmaker/api/monstros.dart.';
import 'package:dio/dio.dart';

class monstrosapi {
  final dio = Dio();
  String baseUrl = 'https://www.dnd5eapi.co/api/2014/monsters';

  findByCep(String nome) async {
    late Monstros monstros;
    final response = await dio.get('$baseUrl/ws/$nome/json/');

    if (response.statusCode == 200) {
      monstros = Monstros.fromJson(response.data);
    }

    return monstros;
  }
}